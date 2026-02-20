# Skill: Daily Index Update

> 每日自动更新 index 仓库的 AI 新闻和资源索引

---

## Purpose

自动化完成两项任务：
1. **采集 AI 内容** → 生成 `ai-news/YYYY-MM-DD.md`
2. **维护资源索引** → 更新 `resources/` 下的 stars 数据

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
| `commit_hash` | Git log | 提交的 commit ID |
| `summary` | Console | 更新摘要 |

---

## Workflow

### Part 1: Update AI News

采集三方面内容，**不强制数量**，有多少算多少：

#### Step 1.1 - AI Industry News
```bash
./tools/tavily-search.sh \
  "AI artificial intelligence LLM OpenAI Anthropic Google latest news" \
  10 > /tmp/news.json

# 提取结果（不强制数量，可能0-10条）
jq -r '.results[] | "- [\(.title)](\(.url))"' /tmp/news.json
```

**Acceptance Criteria**:
- 来源可靠（TechCrunch、MIT TR、机器之心等）
- 内容完整（非付费墙、非404）
- 近 24 小时内
- ❌ **不凑数**：不足10条就记录实际数量

#### Step 1.2 - GitHub Trending
```bash
./tools/tavily-search.sh \
  "site:github.com/trending AI agent LLM" \
  10 > /tmp/trending.json

# 提取 AI/Agent 相关项目
jq -r '.results[] | select(.title | contains("AI"))' /tmp/trending.json
```

**Acceptance Criteria**:
- 与 AI/Agent 强相关
- 项目质量达标（stars>1000、文档完整）
- ❌ **不凑数**：可能0-5个有效结果

#### Step 1.3 - arXiv Papers
```bash
./tools/tavily-search.sh \
  "site:arxiv.org LLM reasoning agent 2026" \
  10 > /tmp/papers.json

# 筛选近期论文
jq -r '.results[] | "- [\(.title)](\(.url))"' /tmp/papers.json
```

**Acceptance Criteria**:
- arxiv.org/abs 链接
- 近 7 天内发布
- 关键词匹配（reasoning, agent, multimodal）
- ❌ **不凑数**：可能0-3篇相关论文

#### Step 1.4 - Generate Report
```bash
DATE=$(date +%Y-%m-%d)

cat > ai-news/${DATE}.md << 'EOF'
# ${DATE} AI 日报

## AI 新闻
$(echo "实际获取: $(jq '.results | length' /tmp/news.json) 条")
$(jq -r '.results[] | "- [\(.title)](\(.url))"' /tmp/news.json)

## GitHub Trending  
$(echo "实际获取: $(jq '.results | length' /tmp/trending.json) 个")
$(jq -r '.results[] | "- [\(.title)](\(.url))"' /tmp/trending.json)

## arXiv 论文
$(echo "实际获取: $(jq '.results | length' /tmp/papers.json) 篇")
$(jq -r '.results[] | "- [\(.title)](\(.url))"' /tmp/papers.json)

---
*Generated: ${DATE}*  
*Quality > Quantity: 不凑数，只记录真实有价值的内容*
EOF
```

---

### Part 2: Update Resources

检查并更新 `resources/` 目录：

#### Step 2.1 - Check User's Starred Repos
```bash
# 获取 platootalp 最近 star 的仓库
curl -s "https://api.github.com/users/platootalp/starred?per_page=50" \
  | jq -r '.[] | "\(.full_name): \(.stargazers_count)"' \
  > /tmp/my-stars.txt

# 对比现有资源，找出新增项
comm -23 <(sort /tmp/my-stars.txt) <(sort resources/.cache/stars.txt 2>/dev/null)
```

#### Step 2.2 - Update Stars Count (Top 20)
```bash
# 只检查高 star 项目的变化
repos=(
  "ollama/ollama"
  "langgenius/dify" 
  "n8n-io/n8n"
  "langchain-ai/langchain"
  "crewAIInc/crewAI"
  "openai/codex"
  "anthropics/claude-code"
  "huggingface/transformers"
)

for repo in "${repos[@]}"; do
  star=$(curl -s "https://api.github.com/repos/$repo" | jq -r '.stargazers_count // 0')
  echo "$repo: $star"
  sleep 0.6  # rate limit
done > /tmp/stars-update.txt
```

**Update Rule**:
- Stars 变化 > 1000：立即更新文件
- Stars 变化 100-1000：累计批量更新
- Stars 变化 < 100：不更新

#### Step 2.3 - Apply Updates
```bash
# 替换 resources/ai-agent.md 中的 stars 数值
# 保持原有排序和格式
```

---

## Git Commit

```bash
cd ~/road/index

git checkout master
git pull origin master

git add ai-news/ resources/

# 生成提交信息
COMMIT_MSG="daily: ${DATE} 更新

Part 1 - AI新闻:
- 新闻: $(jq '.results | length' /tmp/news.json) 条
- Trending: $(jq '.results | length' /tmp/trending.json) 个  
- 论文: $(jq '.results | length' /tmp/papers.json) 篇

Part 2 - 资源:
$(if [ -s /tmp/stars-update.txt ]; then echo "- Stars 已更新"; else echo "- 无显著变化"; fi)

Auto-generated"

if ! git diff --cached --quiet; then
  git commit -m "$COMMIT_MSG"
  git push origin master
  echo "✅ Committed: $(git rev-parse --short HEAD)"
else
  echo "ℹ️ No changes detected"
fi
```

---

## Error Handling

| Scenario | Response |
|----------|----------|
| Tavily API 失败 | 跳过 Part 1，继续 Part 2 |
| GitHub API rate limited | 延迟 60s 后重试，最多 3 次 |
| No new content found | 输出 "今日无新内容"，正常结束 |
| Git push failed | 保留本地变更，下次合并 |

---

## Example Output

```
📅 2026-02-20 Index 更新

Part 1 - AI News:
  ✅ ai-news/2026-02-20.md
     - 新闻: 6 条 (不凑数)
     - Trending: 3 个
     - 论文: 2 篇

Part 2 - Resources:
  ✅ resources/ai-agent.md
     - Stars 更新: 3 个仓库
     - 新增资源: 0 个

Commit: 523cab0
🔗 https://github.com/platootalp/index
```

---

## Related

- `tools/tavily-search.sh` - Tavily API 搜索工具
- `resources/ai-agent.md` - AI-Agent 资源索引
- `resources/general-dev.md` - 通用开发资源
- `ai-news/` - AI 新闻存档目录
