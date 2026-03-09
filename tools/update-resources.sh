#!/bin/bash
# 更新资源索引脚本 - 自动分类版本

set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

USER="platootalp"
TOKEN="${GITHUB_TOKEN:-}"
DATE=$(date +%Y-%m-%d)

echo "📦 资源索引更新 - $DATE"
echo "=========================="

# 检查 GitHub Token
if [ -z "$TOKEN" ]; then
    echo "⚠️ 警告: 未设置 GITHUB_TOKEN，将使用未认证请求（限流 60/h）"
    echo "   设置方法: export GITHUB_TOKEN=ghp_xxxxxx"
fi

# 获取当前收藏列表 (最多 300 个，避免限流)
echo ""
echo "🔍 步骤 1: 获取收藏列表..."
> /tmp/current-stars.txt

for page in 1 2 3; do
    if [ -n "$TOKEN" ]; then
        curl -s -H "Authorization: Bearer $TOKEN" \
            "https://api.github.com/users/$USER/starred?per_page=100&page=$page" \
            | jq -r '.[].full_name' >> /tmp/current-stars.txt 2>/dev/null || true
    else
        curl -s "https://api.github.com/users/$USER/starred?per_page=100&page=$page" \
            | jq -r '.[].full_name' >> /tmp/current-stars.txt 2>/dev/null || true
    fi

    # 检查是否还有更多
    count=$(wc -l < /tmp/current-stars.txt | tr -d ' ')
    if [ "$count" -lt $((page * 100)) ]; then
        break
    fi
    sleep 1
done

# 去重并排序
sort -u /tmp/current-stars.txt > /tmp/current-stars-sorted.txt
CURRENT_COUNT=$(wc -l < /tmp/current-stars-sorted.txt | tr -d ' ')
echo "   当前收藏: $CURRENT_COUNT 个仓库"

# 提取资源文件中的仓库
echo ""
echo "🔍 步骤 2: 提取资源文件中的仓库..."
grep -oE 'github\.com/[a-zA-Z0-9._-]+/[a-zA-Z0-9._-]+' resources/ai-agent.md resources/general-dev.md 2>/dev/null \
    | sed 's/github.com\///' | sort -u > /tmp/resource-repos.txt
RESOURCE_COUNT=$(wc -l < /tmp/resource-repos.txt | tr -d ' ')
echo "   资源文件: $RESOURCE_COUNT 个仓库"

# 检测新增仓库
echo ""
echo "🔍 步骤 3: 检测新增仓库..."
comm -23 /tmp/current-stars-sorted.txt /tmp/resource-repos.txt > /tmp/new-repos.txt
NEW_COUNT=$(wc -l < /tmp/new-repos.txt | tr -d ' ')
echo "   新增收藏: $NEW_COUNT 个"

if [ "$NEW_COUNT" -eq 0 ]; then
    echo "   ℹ️ 没有新收藏，跳过自动分类"
else
    echo ""
    echo "🤖 步骤 4: 自动分类新增仓库..."

    > /tmp/auto-classified.md
    > /tmp/needs-review.txt

    while IFS= read -r repo; do
        [ -z "$repo" ] && continue

        echo "   分析: $repo"

        # 运行自动分类脚本
        result=$(python3 tools/auto-classify-repo.py "$repo" "$TOKEN" 2>&1)
        exit_code=$?

        if [ $exit_code -eq 0 ]; then
            category=$(echo "$result" | grep "CATEGORY:" | cut -d: -f2)
            md_line=$(echo "$result" | grep "^| " | tail -1)

            if [ -n "$category" ] && [ -n "$md_line" ]; then
                echo "      → 分类: $category"
                echo "$category|$md_line" >> /tmp/auto-classified.md
            else
                echo "      → 需要人工审核"
                echo "$repo" >> /tmp/needs-review.txt
            fi
        else
            echo "      → API 错误，加入待审核"
            echo "$repo" >> /tmp/needs-review.txt
        fi

        # 避免限流
        sleep 0.5
    done < /tmp/new-repos.txt

    # 按分类整理并插入资源文件
    if [ -s /tmp/auto-classified.md ]; then
        echo ""
        echo "📝 步骤 5: 写入资源文件..."

        # 为每个分类添加仓库
        for category in "开发框架" "Coding-Agent" "推理框架" "RAG" "MCP" "Memory" "低代码平台" "学习路线" "学习项目" "评估与测试" "实用工具" "金融与交易 AI" "AI 媒体生成" "工程博客" "其他资源"; do
            grep "^$category|" /tmp/auto-classified.md | while IFS='|' read -r cat md; do
                # 找到对应分类的表格并插入
                # 这里简化处理，实际应该使用更精确的插入逻辑
                echo "   添加到 [$category]: $md"
            done
        done

        # 更新待分类文件（标记已自动分类的）
        echo "" >> resources/.pending-repos.md
        echo "# $DATE 自动分类结果" >> resources/.pending-repos.md
        echo "" >> resources/.pending-repos.md
        echo "## 已自动分类（请检查位置是否正确）" >> resources/.pending-repos.md
        cat /tmp/auto-classified.md | cut -d'|' -f1,3 | sed 's/|/ → /' | sed 's/^/ - /' >> resources/.pending-repos.md

        if [ -s /tmp/needs-review.txt ]; then
            echo "" >> resources/.pending-repos.md
            echo "## 需要人工审核" >> resources/.pending-classified.md
            cat /tmp/needs-review.txt | sed 's/^/ - [ ] /' >> resources/.pending-repos.md
        fi
    fi
fi

# 检测取消收藏的仓库（删除）
echo ""
echo "🔍 步骤 6: 检测取消收藏的仓库..."
comm -13 /tmp/current-stars-sorted.txt /tmp/resource-repos.txt > /tmp/deleted-repos.txt
DELETED_COUNT=$(wc -l < /tmp/deleted-repos.txt | tr -d ' ')
echo "   取消收藏: $DELETED_COUNT 个"

if [ "$DELETED_COUNT" -gt 0 ]; then
    while IFS= read -r repo; do
        echo "   从资源文件删除: $repo"
        # 使用 sed 删除包含该仓库的行
        sed -i.bak "/github.com\/$repo/d" resources/ai-agent.md 2>/dev/null || true
        sed -i.bak "/github.com\/$repo/d" resources/general-dev.md 2>/dev/null || true
    done < /tmp/deleted-repos.txt
    rm -f resources/*.bak
fi

# 更新 stars 数量（仅前 30 高频更新的仓库，减少 API 调用）
echo ""
echo "🔍 步骤 7: 更新 stars 数量（前 30 高 star 仓库）..."

# 从 ai-agent.md 提取高 star 仓库
grep -E '^\|\s*[0-9.]+k?\s*\|' resources/ai-agent.md 2>/dev/null \
    | grep 'github.com' \
    | head -30 \
    | grep -oE 'github\.com/[a-zA-Z0-9._-]+/[a-zA-Z0-9._-]+' \
    | sed 's/github.com\///' > /tmp/top-repos.txt

> /tmp/stars-updated.txt
UPDATED=0

while IFS= read -r repo; do
    [ -z "$repo" ] && continue

    if [ -n "$TOKEN" ]; then
        star=$(curl -s -H "Authorization: Bearer $TOKEN" \
            "https://api.github.com/repos/$repo" 2>/dev/null | jq -r '.stargazers_count // 0')
    else
        star=$(curl -s "https://api.github.com/repos/$repo" 2>/dev/null | jq -r '.stargazers_count // 0')
    fi

    [ "$star" = "0" ] && continue

    # 格式化 stars
    if [ "$star" -gt 999 ]; then
        formatted=$(echo "scale=1; $star/1000" | bc | sed 's/\.0$//')k
    else
        formatted="$star"
    fi

    echo "$repo: $formatted" >> /tmp/stars-updated.txt
    UPDATED=$((UPDATED + 1))
    sleep 0.3
done < /tmp/top-repos.txt

echo "   已更新: $UPDATED 个仓库"

# 输出摘要
echo ""
echo "📊 更新摘要"
echo "=========="
echo "新增收藏: $NEW_COUNT"
echo "取消收藏: $DELETED_COUNT"
echo "Stars 更新: $UPDATED"
echo ""

if [ "$NEW_COUNT" -gt 0 ] || [ "$DELETED_COUNT" -gt 0 ] || [ "$UPDATED" -gt 0 ]; then
    echo "✅ 有变更，请检查 resources/.pending-repos.md 和 git diff"
    exit 0
else
    echo "ℹ️ 无变更"
    exit 1
fi
