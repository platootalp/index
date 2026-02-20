# Skill: Daily Index Update

> 每日自动更新 index 仓库的 AI 新闻和资源索引

---

## Purpose

自动化完成两项任务：
1. **采集 AI 内容** → 生成 `ai-news/YYYY-MM-DD.md`
2. **维护资源索引** → 更新 `resources/` 下的资源列表（增删改）

---

## When to Use

- **自动触发**: 每日 08:00 (Asia/Shanghai) 由 Cron 执行
- **手动触发**: 需要立即更新仓库时

---

## Inputs

| Input | Required | Default | Description |
|-------|----------|---------|-------------|
| `DATE` | No | `date +%Y-%m-%d` | 更新日期 |
| `SKIP_NEWS` | No | `false` | 跳过 AI 新闻采集 |
| `SKIP_RESOURCES` | No | `false` | 跳过资源索引更新 |
| `DRY_RUN` | No | `false` | 仅预览，不提交 |

---

## Outputs

| Output | Location | Description |
|--------|----------|-------------|
| `news_file` | `ai-news/{DATE}.md` | 当日 AI 日报 |
| `resources_updated` | `resources/*.md` | 更新的资源文件 |
| `commit_hash` | Git log | 提交的 commit ID |
| `summary` | Console | 更新摘要 |

---

## Workflow

### Part 1: Update AI News

生成 `ai-news/YYYY-MM-DD.md`，包含三部分内容：

#### Step 1.1 - AI Industry News

**采集命令**:
```bash
./tools/tavily-search.sh \
  "AI artificial intelligence LLM OpenAI Anthropic Google latest news" \
  15 > /tmp/news.json
```

**输出格式** (参考 2026-02-19 结构):
```markdown
### N. 文章标题
- **来源**: 媒体名称 (地区/语言)
- **摘要**: 50-100字核心内容概括
- **链接**: 完整URL (不隐藏)
- **访问状态**: ✅可直接访问 / ⚠️海外站需代理 / ❌需翻墙
```

**Acceptance Criteria**:
- 来源可靠（TechCrunch、The Verge、MIT TR、机器之心、36kr等）
- 摘要简洁，概括核心信息
- 链接完整显示，不隐藏
- 标注访问状态（帮助用户判断可访问性）
- ❌ **不凑数**：有多少算多少

#### Step 1.2 - GitHub Trending

**采集命令**:
```bash
./tools/tavily-search.sh \
  "site:github.com/trending AI agent LLM" \
  10 > /tmp/trending.json
```

**输出格式**:
```markdown
### N. user/repo-name
- **简介**: 项目一句话描述
- **语言**: 主要编程语言
- **增长**: +X stars (今日/本周)
- **链接**: https://github.com/user/repo
```

**Acceptance Criteria**:
- 与 AI/Agent 强相关
- 质量达标（stars>1000、文档完整）
- ❌ **不凑数**：关联度低则不记录

#### Step 1.3 - arXiv Papers

**采集命令**:
```bash
./tools/tavily-search.sh \
  "site:arxiv.org LLM reasoning agent 2025" \
  10 > /tmp/papers.json
```

**输出格式** (必须包含完整字段):
```markdown
### N. 论文完整标题
- **作者**: 作者列表
- **arXiv**: ID [cs.XX] 
- **贡献**: 100-150字核心贡献描述（做了什么、解决什么问题、效果/意义）
- **链接**: https://arxiv.org/abs/XXXX.XXXXX
- **访问状态**: ✅ 可直接访问
```

**Acceptance Criteria**:
- arxiv.org/abs 或 arxiv.org/html 链接
- **必须包含**: 作者、arXiv ID、贡献摘要、完整URL
- 近 7 天内发布优先
- 关键词匹配（reasoning, agent, multimodal）
- ❌ **不凑数**：有效论文数量即可

#### Step 1.4 - Generate Report

**文件模板**:
```markdown
# YYYY-MM-DD AI 日报

> 采集时间: YYYY-MM-DD HH:MM (Asia/Shanghai)
> 来源: Tavily API

---

## 🔥 热点新闻

[AI新闻列表]

---

## 🚀 GitHub Trending

[Trending项目列表，或说明不凑数]

---

## 📚 最新 AI 论文

[论文列表，含作者/arXiv/贡献/链接/访问状态]

---

## 💡 今日总结

1. [核心事件1]
2. [核心事件2]
3. [论文亮点]
4. [访问提示]

---

*自动收集 by OpenClaw*
```

---

### Part 2: Update Resources (增删改)

**核心逻辑**: 每日检查用户的 starred 仓库列表，与现有资源对比，执行 **增删改**。

#### Step 2.1 - 获取当前 Starred 列表

```bash
# 获取用户 platootalp 所有 starred 仓库（最多 1000 个）
get_starred() {
  page=1
  > /tmp/current-stars.txt
  while true; do
    curl -s -H "Authorization: Bearer $TOKEN" \
      "https://api.github.com/users/platootalp/starred?per_page=100&page=$page" \
      | jq -r '.[].full_name' >> /tmp/current-stars.txt
    
    count=$(wc -l < /tmp/current-stars.txt)
    [ $count -lt $((page * 100)) ] && break
    page=$((page + 1))
    sleep 1
  done
}

get_starred
```

#### Step 2.2 - 提取资源文件中的仓库

```bash
# 从 ai-agent.md 提取
extract_repos() {
  grep -oE 'github\.com/[a-zA-Z0-9._-]+/[a-zA-Z0-9._-]+' resources/ai-agent.md resources/general-dev.md 2>/dev/null \
    | sed 's/github.com\///' | sort | uniq > /tmp/resource-repos.txt
}

extract_repos
```

#### Step 2.3 - 执行增删改

```bash
# 1. 检测新增（已 star 但不在资源中）
NEW_REPOS=$(comm -23 <(sort /tmp/current-stars.txt) <(sort /tmp/resource-repos.txt))
echo "=== 新增 $(echo "$NEW_REPOS" | wc -l) 个仓库 ==="

# 2. 检测删除（在资源中但已 unstar）
DELETED_REPOS=$(comm -13 <(sort /tmp/current-stars.txt) <(sort /tmp/resource-repos.txt))
DELETED_COUNT=$(echo "$DELETED_REPOS" | wc -l)
echo "=== 删除 $DELETED_COUNT 个仓库 ==="

# 3. 更新 stars 数量（前50高 star 项目）
TOP_REPOS=$(grep -E '^\|\s*[0-9.]+k\s*\|' resources/ai-agent.md resources/general-dev.md 2>/dev/null \
  | grep 'github.com' \
  | sort -t'|' -k2 -rn | head -50 \
  | grep -oE 'github\.com/[a-f0-9._-]+/[a-zA-Z0-9._-]+' \
  | sed 's/github.com\///')

for repo in $TOP_REPOS; do
  star=$(curl -s -H "Authorization: Bearer $TOKEN" \
    "https://api.github.com/repos/$repo" | jq -r '.stargazers_count // 0')
  echo "$repo: $star"
  sleep 0.5
done > /tmp/stars-update.txt
```

#### Step 2.4 - 处理删除

```bash
# 从资源文件中删除已 unstar 的仓库
for repo in $DELETED_REPOS; do
  echo "删除: $repo"
  
  # 从 ai-agent.md 删除对应行
  sed -i '' "/github.com\/$repo/d" resources/ai-agent.md
  
  # 从 general-dev.md 删除对应行
  sed -i '' "/github.com\/$repo/d" resources/general-dev.md
done

# 如果删除导致某分类为空，标记该分类
# （可选：完全删除空分类）
```

#### Step 2.5 - 处理新增

```bash
# 新增仓库需要人工判断分类，暂时记录到 pending 文件
if [ -n "$NEW_REPOS" ]; then
  echo "# $DATE 新增仓库（待分类）" >> resources/.pending-repos.md
  echo "" >> resources/.pending-repos.md
  for repo in $NEW_REPOS; do
    echo "- [ ] $repo" >> resources/.pending-repos.md
  done
  echo "" >> resources/.pending-repos.md
fi
```

#### Step 2.6 - 更新 Stars 数值

```bash
# 读取 /tmp/stars-update.txt，更新资源文件中的 stars 数值
while read line; do
  repo=$(echo "$line" | cut -d: -f1)
  new_stars=$(echo "$line" | cut -d: -f2 | tr -d ' ')
  
  # 转换数值格式（如 12345 -> 12.3k）
  if [ "$new_stars" -gt 999 ]; then
    formatted=$(echo "scale=1; $new_stars/1000" | bc | sed 's/\.0$//')k
  else
    formatted=$new_stars
  fi
  
  # 更新 ai-agent.md
  sed -i '' "s|[0-9.]*k| **$repo**|$formatted| **$repo**|g" resources/ai-agent.md
  
  # 更新 general-dev.md
  sed -i '' "s|[0-9.]*k| **$repo**|$formatted| **$repo**|g" resources/general-dev.md
done < /tmp/stars-update.txt
```

#### Step 2.7 - 重新排序

```bash
# 删除后可能需要重新分类排序
# 按每个分类内的 stars 降序重新排列

python3 << 'PYEOF'
import re

# 读取文件
with open('resources/ai-agent.md', 'r') as f:
    content = f.read()

# 按分类分割，每个分类内按 stars 排序
# 实现略（根据实际表格格式）

# 保存
with open('resources/ai-agent.md', 'w') as f:
    f.write(content)
PYEOF
```

---

## Git Commit

```bash
cd ~/road/index

git checkout master
git pull origin master

# 统计变更
ADDED=$(echo "$NEW_REPOS" | grep -v "^$" | wc -l)
DELETED=$DELETED_COUNT
MODIFIED=$(wc -l < /tmp/stars-update.txt)

git add ai-news/ resources/

git commit -m "daily: ${DATE} 资源更新

Part 1 - AI新闻:
- 新闻: X 条
- Trending: X 个  
- 论文: X 篇

Part 2 - 资源（增删改）:
- 新增: $ADDED 个仓库（已记录到 .pending-repos.md）
- 删除: $DELETED 个仓库（已取消 star）
- 更新: $MODIFIED 个仓库（stars 数更新）

Auto-generated"

git push origin master
```

---

## 输出摘要

```
📅 ${DATE} Index 更新完成

Part 1 - AI News:
  ✅ ai-news/${DATE}.md
     - 新闻: X 条
     - Trending: X 个
     - 论文: X 篇

Part 2 - Resources:
  ✅ 新增: X 个仓库（待分类）
  ✅ 删除: X 个仓库（已 unstar）
  ✅ 更新: X 个仓库（stars 刷新）
  ✅ 文件: resources/ai-agent.md resources/general-dev.md

Pending: resources/.pending-repos.md（需人工分类）

Commit: xxxxxxx
🔗 https://github.com/platootalp/index
```

---

## Error Handling

| Scenario | Response |
|----------|----------|
| Tavily API 失败 | 跳过 Part 1，继续 Part 2 |
| GitHub API rate limit | 延迟 60s 后重试，最多 3 次 |
| 获取 starred 列表失败 | 使用缓存的上次列表 |
| 无新增/删除/修改 | 正常结束，输出 "今日无变更" |
| Git push failed | 保留本地变更，下次合并 |
| 删除后分类为空 | 标记该分类，不自动删除分类标题 |

---

## 新增文件

| 文件 | 用途 |
|------|------|
| `resources/.pending-repos.md` | 新增仓库待分类列表 |
| `.last-stars-check` | 上次检查的缓存（可选） |

---

## 手动验证

```bash
# 查看新增仓库
cat resources/.pending-repos.md

# 验证删除
grep "deleted-repo-name" resources/ai-agent.md

# 查看 star 数变化
diff <(git show HEAD:resources/ai-agent.md | grep -E '^\|.*k.*github') <(cat resources/ai-agent.md | grep -E '^\|.*k.*github')
```

---

## Related

- `tools/tavily-search.sh` - Tavily API 搜索工具
- `resources/ai-agent.md` - AI-Agent 资源索引
- `resources/general-dev.md` - 通用开发资源
- `ai-news/` - AI 新闻存档目录
- `ai-news/TEMPLATE.md` - 日报格式模板
- `ai-news/2026-02-19.md` - 参考示例
