# 每日更新工作流程

> 自动化更新 index 仓库的 AI 新闻和资源索引

## 触发方式

- **定时触发**: 每日 08:00 (Asia/Shanghai)
- **手动触发**: 通过 `cron run` 命令执行

## 工作流程步骤

### Step 1: 更新 AI 新闻

采集昨日 AI 领域重要动态：

```bash
# 设置日期
DATE=$(date +%Y-%m-%d)
YESTERDAY=$(date -v-1d +%Y-%m-%d)

# 使用 Tavily API 搜索 AI 新闻
./tools/tavily-search.sh \
  "AI artificial intelligence LLM OpenAI Anthropic Google latest news ${YESTERDAY}" \
  15 > /tmp/ai-news-raw.json

# 解析并格式化
# 输出: ai-news/${DATE}.md
```

**输出要求**:
- 至少 5 条有效新闻
- 包含：标题、来源、摘要、链接
- 优先中文/国内可访问源

### Step 2: 更新资源 Stars

检查资源索引中的 GitHub Stars 变化：

```bash
# 遍历 resources/ai-agent.md 和 resources/general-dev.md 中的 GitHub 链接
# 获取最新 stars 数量
# 如有变化，更新文件

get_star() {
  curl -s "https://api.github.com/repos/$1" | jq -r '.stargazers_count // 0'
  sleep 0.6  # 避免 rate limit
}

# 示例：获取前10个高star仓库的最新数据
for repo in "ollama/ollama" "openai/codex" "anthropics/claude-code"; do
  echo "$repo: $(get_star $repo)"
done
```

**更新规则**:
- 仅更新 stars 变化 > 1000 的仓库
- 保持原有分类和排序
- 更新统计表格

### Step 3: 检测新 Trending 项目

检查 GitHub Trending 是否有新的 AI/Agent 相关项目：

```bash
./tools/tavily-search.sh \
  "site:github.com/trending AI agent LLM" \
  10 > /tmp/github-trending.json

# 解析 trending 项目
# 判断是否已存在于资源列表
# 如为新项目且质量达标，添加到「实用资源-新发现」暂存区
```

### Step 4: 提交更新

```bash
cd ~/road/index

git checkout master
git pull origin master

# 添加变更
git add ai-news/
git add resources/

# 提交
if git diff --cached --quiet; then
  echo "No changes to commit"
else
  git commit -m "daily: ${DATE} 更新
  
- AI新闻: ${DATE}.md
- 资源更新: stars数据刷新
- 自动采集"
  
  git push origin master
fi
```

## 输出通知

任务完成后，输出摘要：

```
📅 2026-02-20 更新完成

✅ AI新闻: 新增 8 条
✅ Stars更新: 15 个仓库
📊 热门增长: 
  - ollama/ollama +1.2k ⭐
  - openai/codex +0.8k ⭐

🔗 https://github.com/platootalp/index
```

## 错误处理

| 错误类型 | 处理方式 |
|---------|---------|
| Tavily API 失败 | 跳过新闻更新，继续其他步骤 |
| GitHub API rate limit | 延迟 60s 后重试，最多 3 次 |
| git push 失败 | 保留本地变更，下次任务合并 |
| 无网络 | 记录错误，下次任务恢复 |

## 配置文件

```yaml
# .github/cron-config.yaml
daily_update:
  schedule: "0 8 * * *"  # 每天 8:00
  timezone: "Asia/Shanghai"
  
  sources:
    ai_news:
      - tavily_api
      min_results: 5
      
    github_stars:
      check_top: 50  # 只检查前50个高star项目
      update_threshold: 1000  # 变化超过1000才更新
      
    trending:
      enabled: true
      max_new: 3  # 每天最多添加3个新项目
```

## 手动执行

```bash
# 模拟执行（不提交）
dry-run: true

# 完整执行
cron run daily-update-index
```
