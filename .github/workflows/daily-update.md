# 每日更新工作流程

> 自动化更新 index 仓库的 AI 新闻和资源索引

**触发方式**: 每日 08:00 (Asia/Shanghai) 自动执行

---

## 第一部分：更新 AI 新闻

生成 `ai-news/YYYY-MM-DD.md` 文件，包含三方面内容：

### 1.1 每日 AI 新闻 (10条)

**来源**: Tavily API 搜索

```bash
./tools/tavily-search.sh \
  "AI artificial intelligence LLM OpenAI Anthropic Google latest news today" \
  15
```

**筛选标准**:
- 优先：TechCrunch、The Verge、MIT Technology Review、机器之心、36kr
- 排除：需翻墙访问、社交媒体、博客spam
- 要求：标题清晰、内容完整、链接可访问

**输出格式**:
```markdown
### AI 新闻

| 标题 | 来源 | 摘要 |
|------|------|------|
| [xxx] | TechCrunch | 一句话摘要 |
```

### 1.2 每日 GitHub Trending (10个)

**来源**: GitHub Trending 页面 + Tavily 搜索

```bash
./tools/tavily-search.sh \
  "site:github.com/trending AI agent LLM machine learning today" \
  15
```

**筛选标准**:
- 项目类型：Agent框架、LLM工具、AI应用
- 排除：个人学习仓库、空壳项目、fork仓库
- 必须含：项目名、简介、今日Star增长数

**输出格式**:
```markdown
### GitHub Trending

| 项目 | 简介 | 语言 | 今日⭐ |
|------|------|------|-------:|
| user/repo | 简介 | Python | +1.2k |
```

### 1.3 每日新增 AI 论文 (10篇)

**来源**: arXiv 最新论文

```bash
./tools/tavily-search.sh \
  "site:arxiv.org LLM reasoning agent multimodal 2026" \
  15
```

**筛选标准**:
- 限定：arxiv.org/abs 链接
- 日期：最近7天
- 关键词：reasoning, agent, multimodal, efficiency, safety
- 排除：纯理论、旧论文（>30天）

**输出格式**:
```markdown
### arXiv 论文

| 标题 | 作者 | 关键词 |
|------|------|--------|
| [Paper Title](link) | Author et al. | reasoning, agent |
```

---

## 第二部分：更新资源索引

检查并更新 `resources/` 目录下的资源文件：

### 2.1 检查 Stars 变化

**目标文件**:
- `resources/ai-agent.md` (155+ 资源)
- `resources/general-dev.md` (44 资源)

**执行方式**:
```bash
# 提取所有 GitHub 仓库链接
grep -oE 'github\.com/[^)]+' resources/ai-agent.md | sort | uniq

# 批量获取最新 stars（注意 rate limit）
# 每小时限制 60 次（未认证）或 5000 次（认证）
```

**更新策略**:
| 情况 | 处理方式 |
|------|---------|
| Stars 增长 > 1000 | 更新数值，保持排序 |
| Stars 增长 100-1000 | 记录变化，批量更新 |
| Stars 增长 < 100 | 暂不更新 |
| 仓库 Archived/Deleted | 标记或移除 |
| 新增重要版本/Release | 更新简介描述 |

### 2.2 检测新资源

**来源**:
- GitHub Trending（与第一部分共享数据）
- Hacker News AI 相关帖子
- Twitter/X 热门项目

**入库标准**:
- ⭐ Stars > 5000（框架类）或 > 1000（工具类）
- 最近 30 天内活跃
- 文档完整、有实际应用场景
- 与 AI/Agent 强相关

**新增流程**:
1. 在 `resources/ai-agent.md` 中找到合适分类
2. 按 stars 数量插入正确位置
3. 更新分类计数统计

### 2.3 资源去重检查

```bash
# 检查重复资源名
grep -oE '\*\*[^*]+\*\*' resources/ai-agent.md | sort | uniq -c | sort -rn

# 如有重复 >1，标记需要处理
```

---

## Git 提交规范

```bash
cd ~/road/index
git checkout master
git pull origin master

# 添加变更
git add ai-news/
git add resources/

# 提交信息
git commit -m "daily: $(date +%Y-%m-%d) 自动更新

$(if [ -f ai-news/$(date +%Y-%m-%d).md ]; then echo '- AI新闻: 新增 $(date +%Y-%m-%d).md'; fi)
$(if git diff --cached resources/ | grep -q '^+.*k'; then echo '- 资源索引: GitHub stars 更新'; fi)

自动生成"

git push origin master
```

---

## 输出通知模板

任务完成后输出：

```
📅 $(date +%Y-%m-%d) Index 仓库更新报告

## 第一部分：AI 新闻
✅ ai-news/$(date +%Y-%m-%d).md
   - AI 新闻: X 条
   - GitHub Trending: X 个
   - arXiv 论文: X 篇

## 第二部分：资源索引
✅ resources/ai-agent.md
   - Stars 更新: X 个仓库
   - 新增资源: X 个

🔗 https://github.com/platootalp/index
```

---

## 错误处理

| 阶段 | 错误类型 | 处理策略 |
|------|---------|---------|
| Part 1 | Tavily API 失败 | 重试3次，失败则跳过 Part 1 |
| Part 1 | 结果不足10条 | 降低筛选标准，输出可用内容 |
| Part 2 | GitHub API rate limit | 延迟执行，使用缓存数据 |
| Part 2 | 仓库不存在 | 标记为待清理 |
| Git | push 失败 | 保留本地，下次合并 |

---

## 手动执行命令

```bash
# 执行完整流程
cd ~/road/index && ./.github/workflows/daily-update.sh

# 仅执行 Part 1 (AI新闻)
./tools/tavily-search.sh "AI latest news" 15

# 仅执行 Part 2 (资源检查)
./scripts/check-stars.sh resources/ai-agent.md
```

---

## 相关文件

- `~/road/index/ai-news/` - AI 新闻存档
- `~/road/index/resources/ai-agent.md` - AI-Agent 资源索引
- `~/road/index/resources/general-dev.md` - 通用开发资源
- `~/road/index/tools/tavily-search.sh` - Tavily API 采集工具
