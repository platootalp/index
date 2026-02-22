# 🤖 Agent 开发工程师学习资源

> 📚 AI 与 Agent 技术精选资源库 | 专注大模型应用开发

---

## 📖 关于本仓库

本仓库是 **Agent 开发工程师的学习资源索引**，包含两大部分：

### 1️⃣ 资源索引
系统整理的 AI/Agent 开发资源，涵盖框架、工具、教程、项目等 **150+ 精选资源**，每个资源都标注了 GitHub Stars 并按热度排序。

- 🤖 **AI/Agent 资源**（本文件）- 155+ 个
- 🔧 **[通用开发资源](OTHER.md)** - 44 个

### 2️⃣ AI 新闻订阅
---

## 📋 目录

- **[一、开发工具与框架](#一开发工具与框架)** (28个)
  - [1.1 开发框架](#11-开发框架) (10个)
  - [1.2 推理框架与模型部署](#12-推理框架与模型部署) (7个)
  - [1.3 Coding-Agent](#13-coding-agent) (9个)
  - [1.4 低代码平台](#14-低代码平台) (5个)
- **[二、核心技术](#二核心技术)** (24个)
  - [2.1 Prompt](#21-prompt) (2个)
  - [2.2 RAG](#22-rag) (6个)
  - [2.3 Memory](#23-memory) (1个)
  - [2.4 通信协议](#24-通信协议) (5个)
  - [2.5 DeepResearch](#25-deepresearch) (1个)
  - [2.6 Skills](#26-skills) (7个)
- **[三、学习资源](#三学习资源)** (28个)
  - [3.1 学习路线](#31-学习路线) (16个)
  - [3.2 书籍与笔记](#32-书籍与笔记) (5个)
  - [3.3 学习项目](#33-学习项目) (7个)
- **[四、评估与测试](#四评估与测试)** (1个)
- **[五、实用资源](#五实用资源)** (20个)
  - [5.1 开发者平台](#51-开发者平台) (2个)
  - [5.2 GUI工具](#52-gui工具) (1个)
  - [5.3 实用工具](#53-实用工具) (7个)
  - [5.4 AI 媒体生成](#54-ai-媒体生成) (5个)
  - [5.5 金融与交易 AI](#55-金融与交易-ai) (8个)
- **[六、开发实践](#六开发实践)** (6个)
  - [6.1 工程博客](#61-工程博客) (3个)
  - [6.2 SDD规范](#62-sdd规范) (1个)
  - [6.3 Vibe-Coding](#63-vibe-coding) (2个)
- **[七、其他资源](#七其他资源)** (8个)
  - [7.1 源码阅读工具](#71-源码阅读工具) (2个)
  - [7.2 社区关注](#72-社区关注) (6个)

---

## 一、开发工具与框架

*Agent 开发的主流框架、工具和平台，按 Stars 排序*

### 1.1 开发框架

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 175.7k | **n8n** | 工作流自动化平台 | [🔗](https://github.com/n8n-io/n8n) |
| 130.0k | **dify** | LLM 应用开发平台 | [🔗](https://github.com/langgenius/dify) |
| 127.1k | **langchain** | 构建可靠 Agents 的平台 | [🔗](https://github.com/langchain-ai/langchain) |
| 47.1k | **llama_index** | LLM 数据框架 | [🔗](https://github.com/run-llama/llama_index) |
| 44.4k | **crewAI** | 多智能体系统框架 | [🔗](https://github.com/crewAIInc/crewAI) |
| 37.5k | **agno** | 构建多智能体系统 | [🔗](https://github.com/agno-agi/agno) |
| 24.2k | **langgraph** | 构建弹性语言 Agent（图结构） | [🔗](https://github.com/langchain-ai/langgraph) |
| 19.0k | **openai-agents-python** | OpenAI Agents SDK | [🔗](https://github.com/openai/openai-agents-python) |
| 17.8k | **adk-python** | Google ADK（Agent 开发套件） | [🔗](https://github.com/google/adk-python) |

### 1.2 推理框架与模型部署

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 163.1k | **ollama** | 本地运行大模型（Kimi, DeepSeek, Qwen 等） | [🔗](https://github.com/ollama/ollama) |
| 156.8k | **transformers** | Transformers 模型定义框架 | [🔗](https://github.com/huggingface/transformers) |
| 122.8k | **open-webui** | 用户友好 AI 界面（支持 Ollama） | [🔗](https://github.com/open-webui/open-webui) |
| 69.4k | **vllm** | 高性能 LLM 推理和服务引擎 | [🔗](https://github.com/vllm-project/vllm) |
| 51.6k | **unsloth** | 快速微调 LLM（提速 2 倍，显存减少 70%） | [🔗](https://github.com/unslothai/unsloth) |
| 41.5k | **DeepSpeed** | 微软深度学习优化库 | [🔗](https://github.com/deepspeedai/DeepSpeed) |
| 10.8k | **text-generation-inference** | HuggingFace TGI 推理引擎 | [🔗](https://github.com/huggingface/text-generation-inference) |

### 1.3 Coding-Agent

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 107.2k | **opencode** | AnomalyCo 开源 Coding Agent | [🔗](https://github.com/anomalyco/opencode) |
| 94.9k | **gemini-cli** | Google Gemini CLI | [🔗](https://github.com/google-gemini/gemini-cli) |
| 67.8k | **claude-code** | Anthropic 官方 Coding Agent | [🔗](https://github.com/anthropics/claude-code) |
| 61.1k | **codex** | OpenAI 官方 Coding Agent | [🔗](https://github.com/openai/codex) |
| 55.4k | **superpowers** | Claude Code 增强插件 | [🔗](https://github.com/obra/superpowers) |
| 48.4k | **everything-claude-code** | Claude Code 资源合集 | [🔗](https://github.com/affaan-m/everything-claude-code) |
| 32.4k | **oh-my-opencode** | opencode 最佳增强工具 | [🔗](https://github.com/code-yeongyu/oh-my-opencode) |
| 21.5k | **vibe-kanban** | 让 Claude Code/Codex 效率提升 10 倍 | [🔗](https://github.com/BloopAI/vibe-kanban) |

### 1.4 低代码平台

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 54.2k | **anything-llm** | 一站式 AI 应用（RAG + Agent 构建器） | [🔗](https://github.com/Mintplex-Labs/anything-llm) |
| - | **coze** | 扣子 AI 应用平台 | [🔗](https://www.coze.cn/) |

---

## 二、核心技术

*Agent 开发的核心技术栈，按 Stars 排序*

### 2.1 Prompt

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 21.5k | **prompt-optimizer** | Prompt 优化器 | [🔗](https://github.com/linshenkx/prompt-optimizer) |
| - | **promptingguide** | Prompt 工程指南（中文） | [🔗](https://www.promptingguide.ai/zh) |

### 2.2 RAG

#### RAG 框架

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 73.5k | **ragflow** | 开源 RAG 引擎 | [🔗](https://github.com/infiniflow/ragflow) |
| 31.0k | **graphrag** | 微软 GraphRAG | [🔗](https://github.com/microsoft/graphrag) |

#### 文档处理

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 54.5k | **MinerU** | 开源文档解析工具 | [🔗](https://github.com/opendatalab/MinerU) |
| 14.0k | **unstructured** | 非结构化数据处理 | [🔗](https://github.com/Unstructured-IO/unstructured) |

#### Vector-DB

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 42.9k | **milvus** | 开源向量数据库 | [🔗](https://github.com/milvus-io/milvus) |

### 2.3 Memory

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 47.6k | **mem0** | AI 应用的记忆层 | [🔗](https://github.com/mem0ai/mem0) |

### 2.4 通信协议

#### MCP (Model Context Protocol)

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 80.3k | **awesome-mcp-servers** | MCP 服务器精选合集 | [🔗](https://github.com/punkpeye/awesome-mcp-servers) |
| 78.0k | **servers** | MCP 官方服务器集合 | [🔗](https://github.com/modelcontextprotocol/servers) |
| 22.6k | **fastmcp** | 快速构建 MCP 服务器（Python） | [🔗](https://github.com/jlowin/fastmcp) |

#### A2A (Agent-to-Agent)

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 22.0k | **A2A** | Agent 间通信协议 | [🔗](https://github.com/a2aproject/A2A) |

#### ACP (Agent Client Protocol)

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **ACP** | Agent 客户端协议 | [🔗](https://agentclientprotocol.com/get-started/introduction) |

### 2.5 DeepResearch

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 18.2k | **DeepResearch** | 阿里 NLP 深度研究 | [🔗](https://github.com/Alibaba-NLP/DeepResearch) |

### 2.6 Skills

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 72.0k | **skills (anthropics)** | Anthropic Skills 官方 | [🔗](https://github.com/anthropics/skills) |
| 36.0k | **awesome-claude-skills** | Claude Skills 精选 | [🔗](https://github.com/ComposioHQ/awesome-claude-skills) |
| 13.1k | **antigravity-awesome-skills** | 更多 Skills 资源 | [🔗](https://github.com/sickn33/antigravity-awesome-skills) |
| - | **skillsmp** | Skills 市场（中文） | [🔗](https://skillsmp.com/zh) |
| - | **skills.sh** | Skills 市场 | [🔗](https://skills.sh/) |

---

## 三、学习资源

*AI Agent 学习路线、教程书籍与实战项目，按 Stars 排序*

### 3.1 学习路线

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 106.1k | **generative-ai-for-beginners** | 微软：21 节课入门生成式 AI | [🔗](https://github.com/microsoft/generative-ai-for-beginners) |
| 74.5k | **llm-course** | 大语言模型入门课程（含路线图和 Colab） | [🔗](https://github.com/mlabonne/llm-course) |
| 50.0k | **ai-agents-for-beginners** | 微软：12 节课入门 AI Agent | [🔗](https://github.com/microsoft/ai-agents-for-beginners) |
| 41.0k | **chatgpt-on-wechat** | 基于大模型的超级 AI 助理（多平台接入） | [🔗](https://github.com/zhayujie/chatgpt-on-wechat) |
| 27.9k | **ai-engineering-hub** | LLM、RAG 和 AI Agent 深度实战教程 | [🔗](https://github.com/patchy631/ai-engineering-hub) |
| 25.1k | **agents-course** | Hugging Face Agents 官方课程 | [🔗](https://github.com/huggingface/agents-course) |
| 24.8k | **awesome-generative-ai-guide** | 生成式 AI 学习资源大全 | [🔗](https://github.com/aishwaryanr/awesome-generative-ai-guide) |
| 23.2k | **llm-cookbook** | 面向开发者的 LLM 入门教程（吴恩达中文） | [🔗](https://github.com/datawhalechina/llm-cookbook) |
| 23.2k | **llm-action** | 大模型实战项目集合 | [🔗](https://github.com/liguodongiot/llm-action) |
| 23.2k | **llm-universe** | 小白开发者的大模型应用开发教程 | [🔗](https://github.com/datawhalechina/llm-universe) |
| 21.1k | **hello-agents** | Datawhale Agent 开发入门教程 | [🔗](https://github.com/datawhalechina/hello-agents) |

### 3.2 书籍与笔记

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 36.2k | **Coursera-ML-AndrewNg-Notes** | 吴恩达机器学习课程笔记 | [🔗](https://github.com/fengdu78/Coursera-ML-AndrewNg-Notes) |
| 20.3k | **deeplearning_ai_books** | 吴恩达深度学习课程笔记 | [🔗](https://github.com/fengdu78/deeplearning_ai_books) |
| 18.7k | **nndl.github.io** | 《神经网络与深度学习》邱锡鹏 | [🔗](https://github.com/nndl/nndl.github.io) |
| 6.9k | **technical-books** | 程序员必读书单（含 AI/LLM 领域） | [🔗](https://github.com/doocs/technical-books) |

### 3.3 学习项目

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 92.0k | **awesome-llm-apps** | 精选 LLM 应用合集（OpenAI, Anthropic, Gemini） | [🔗](https://github.com/Shubhamsaboo/awesome-llm-apps) |
| 38.7k | **minimind** | 2 小时从 0 训练 26M 小参数 GPT | [🔗](https://github.com/jingyaogong/minimind) |
| 24.4k | **500-AI-Agents-Projects** | 500 个 AI Agent 项目集合 | [🔗](https://github.com/ashishpatel26/500-AI-Agents-Projects) |
| 16.3k | **WeClone** | 从聊天记录创建数字分身 | [🔗](https://github.com/xming521/WeClone) |
| 15.7k | **dexter** | 自主深度金融研究 Agent | [🔗](https://github.com/virattt/dexter) |

---

## 四、评估与测试

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 12.7k | **ragas** | Agent/RAG 评估框架 | [🔗](https://github.com/vibrantlabsai/ragas) |

---

## 五、实用资源

*AI 应用开发中的实用工具和资源，按 Stars 排序*
| 7.4k | **agentic-design-patterns-cn** | 《Agentic Design Patterns》中文版 | [🔗](https://github.com/ginobefun/agentic-design-patterns-cn) |
| 7.4k | **rag-from-scratch** | LangChain 官方 RAG 从零开始教程 | [🔗](https://github.com/langchain-ai/rag-from-scratch) |
| 9.0k | **skills (openai)** | OpenAI Skills 官方 | [🔗](https://github.com/openai/skills) |

### 5.1 开发者平台

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **AI Studio** | Google AI Studio | [🔗](https://aistudio.google.com) |
| - | **OpenAI Developers** | OpenAI 开发者平台 | [🔗](https://developers.openai.com) |

### 5.2 GUI工具

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 16.6k | **AionUi** | AI 应用 GUI 工具 | [🔗](https://github.com/iOfficeAI/AionUi) |

### 5.3 实用工具

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 212.0k | **openclaw** | 个人 AI 助手（跨平台） | [🔗](https://github.com/openclaw/openclaw) |
| 84.9k | **home-assistant** | 开源智能家居平台 | [🔗](https://github.com/home-assistant/core) |
| 60.5k | **crawl4ai** | LLM 友好的开源网页爬虫 | [🔗](https://github.com/unclecode/crawl4ai) |
| 47.7k | **TrendRadar** | AI 趋势雷达 | [🔗](https://github.com/sansan0/TrendRadar) |
| 23.5k | **Open-AutoGLM** | 自动 GUI 操作 Agent | [🔗](https://github.com/zai-org/Open-AutoGLM) |
| 15.1k | **zeroclaw** | 快速轻量 AI 助手基础设施 | [🔗](https://github.com/zeroclaw-labs/zeroclaw) |
| - | **vibekanban** | Vibe Kanban 看板 | [🔗](https://www.vibekanban.com/docs) |
| 9.2k | **valuecell** | 社区驱动的多 Agent 金融应用平台 | [🔗](https://github.com/ValueCell-ai/valuecell) |

### 5.4 AI 媒体生成

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 79.2k | **Deep-Live-Cam** | 实时换脸和一键视频 deepfake | [🔗](https://github.com/hacksider/Deep-Live-Cam) |
| 49.3k | **MoneyPrinterTurbo** | AI 大模型一键生成高清短视频 | [🔗](https://github.com/harry0703/MoneyPrinterTurbo) |
| 28.5k | **CopilotKit** | Agents 和生成式 UI 的前端框架 | [🔗](https://github.com/CopilotKit/CopilotKit) |
| 16.0k | **VideoLingo** | Netflix 级字幕切割、翻译、配音 | [🔗](https://github.com/Huanshere/VideoLingo) |
| 13.0k | **MoneyPrinterV2** | 自动化在线赚钱流程 | [🔗](https://github.com/FujiwaraChoki/MoneyPrinterV2) |

### 5.5 金融与交易 AI

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 59.8k | **OpenBB** | 金融数据平台（分析师、量化、AI Agent） | [🔗](https://github.com/OpenBB-finance/OpenBB) |
| 45.6k | **ai-hedge-fund** | AI 对冲基金团队 | [🔗](https://github.com/virattt/ai-hedge-fund) |
| 29.2k | **TradingAgents** | 多智能体 LLM 金融交易框架 | [🔗](https://github.com/TauricResearch/TradingAgents) |
| 21.6k | **yfinance** | Yahoo Finance 市场数据下载 | [🔗](https://github.com/ranaroussi/yfinance) |
| 18.6k | **FinGPT** | 开源金融大语言模型 | [🔗](https://github.com/AI4Finance-Foundation/FinGPT) |
| 17.5k | **TradingAgents-CN** | TradingAgents 中文增强版 | [🔗](https://github.com/hsliuping/TradingAgents-CN) |

---

## 六、开发实践

*工程实践、规范与前沿方法论*

### 6.1 工程博客

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 33.1k | **claude-cookbooks** | Anthropic 官方 Cookbook | [🔗](https://github.com/anthropics/claude-cookbooks) |
| 71.5k | **openai-cookbook** | OpenAI 官方 Cookbook（含 Agents 专题） | [🔗](https://github.com/openai/openai-cookbook) |
| - | **Anthropic Engineering** | Anthropic 工程博客 | [🔗](https://www.anthropic.com/engineering) |

### 6.2 SDD规范

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 70.6k | **spec-kit** | GitHub SDD 规范套件 | [🔗](https://github.com/github/spec-kit) |

### 6.3 Vibe-Coding

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 12.2k | **vibe-coding-cn** | Vibe Coding 中文资源 | [🔗](https://github.com/2025Emma/vibe-coding-cn) |

---

## 七、其他资源

*源码阅读、社区关注等补充资源*

### 7.1 源码阅读工具

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **deepwiki** | AI 源码阅读工具 | [🔗](https://deepwiki.com/) |
| - | **zread** | AI 代码解读 | [🔗](https://zread.ai/) |

### 7.2 社区关注

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **datawhalechina** | Datawhale 开源社区 | [🔗](https://github.com/datawhalechina) |
| - | **anthropics** | Anthropic 官方 | [🔗](https://github.com/anthropics) |
| - | **claudecn** | Claude 中文社区 | [🔗](https://claudecn.com/) |
| - | **openclawcn** | OpenClaw 中文社区 | [🔗](https://openclawcn.com/) |
| - | **github.blog** | GitHub AI/ML 博客 | [🔗](https://github.blog/ai-and-ml/) |

---

## 📊 资源统计

| 分类 | 数量 |
|------|------|
| 开发工具与框架 | 28 个 |
| 核心技术 | 24 个 |
| 学习资源 | 28 个 |
| 评估与测试 | 1 个 |
| 实用资源 | 20 个 |
| 开发实践 | 6 个 |
| 其他资源 | 8 个 |
| **总计** | **115+ 个** |

> 📰 AI 新闻订阅请查看 [根目录 README](../README.md)

---

*📅 更新时间: 2026-02-20*

*⭐ Stars 数据实时获取，按数量倒序排列*

*🤖 专注 Agent 开发工程师成长*
