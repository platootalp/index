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

### Part 2: Update Resources

检查并更新 `resources/` 目录：

#### Step 2.1 - Check User's Starred Repos

```bash
# 获取 platootalp 最近 star 的仓库
curl -s "https://api.github.com/users/platootalp/starred?per_page=50" \
  | jq -r '.[] | "\(.full_name): \(.stargazers_count)"' \
  > /tmp/my-stars.txt

# 对比现有资源，找出新增项
```

#### Step 2.2 - Update Stars Count (Top 20)

```bash
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
  star=$(curl -s "https://api.github.com/repos/$repo" \
    | jq -r '.stargazers_count // 0')
  echo "$repo: $star"
  sleep 0.6  # rate limit
done > /tmp/stars-update.txt
```

**Update Rule**:
- Stars 变化 > 1000：立即更新文件
- Stars 变化 100-1000：记录，批量更新
- Stars 变化 < 100：不更新

#### Step 2.3 - Apply Updates

- 替换 `resources/ai-agent.md` 中的 stars 数值
- 保持原有排序和格式
- 更新统计表格

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
- 新闻: X 条
- Trending: X 个  
- 论文: X 篇

Part 2 - 资源:
- Stars 更新: X 个仓库
- 访问状态标记已更新

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
| 论文摘要获取失败 | 标注 "摘要待补充"，不跳过 |
| Git push failed | 保留本地变更，下次合并 |

---

## Example Output

```
📅 2026-02-20 Index 更新

Part 1 - AI News:
  ✅ ai-news/2026-02-20.md
     - 新闻: 5 条
     - Trending: 0 个 (不凑数)
     - 论文: 7 篇

Part 2 - Resources:
  ✅ resources/ai-agent.md
     - Stars 更新: 3 个仓库

Commit: f88230d
🔗 https://github.com/platootalp/index
```

---

## Related

- `tools/tavily-search.sh` - Tavily API 搜索工具
- `resources/ai-agent.md` - AI-Agent 资源索引
- `resources/general-dev.md` - 通用开发资源
- `ai-news/` - AI 新闻存档目录
- `ai-news/TEMPLATE.md` - 日报格式模板
- `ai-news/2026-02-19.md` - 参考示例
