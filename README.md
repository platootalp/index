# 🤖 Agent 开发工程师学习资源

> 📚 AI 与 Agent 技术精选资源库 | 专注大模型应用开发

---

## 📋 目录

- **[一、开发工具与框架](#一开发工具与框架)** (23个)
  - [1.1 开发框架](#11-开发框架) (8个)
  - [1.2 推理框架与模型部署](#12-推理框架与模型部署) (6个)
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
| 125.9k | **langchain** | 构建可靠 Agents 的平台 | [🔗](https://github.com/langchain-ai/langchain) |
| 128.6k | **dify** | LLM 应用开发平台 | [🔗](https://github.com/langgenius/dify) |
| 172.9k | **n8n** | 工作流自动化平台 | [🔗](https://github.com/n8n-io/n8n) |
| 47.1k | **llama_index** | LLM 数据框架 | [🔗](https://github.com/run-llama/llama_index) |
| 24.2k | **langgraph** | 构建弹性语言 Agent（图结构） | [🔗](https://github.com/langchain-ai/langgraph) |
| 44.3k | **crewAI** | 多智能体系统框架 | [🔗](https://github.com/crewAIInc/crewAI) |
| 37.5k | **agno** | 构建多智能体系统 | [🔗](https://github.com/agno-agi/agno) |
| 19.0k | **openai-agents-python** | OpenAI Agents SDK | [🔗](https://github.com/openai/openai-agents-python) |
| 17.8k | **adk-python** | Google ADK（Agent 开发套件） | [🔗](https://github.com/google/adk-python) |
| 7.9k | **spring-ai** | Spring AI 工程框架 | [🔗](https://github.com/spring-projects/spring-ai) |

**该分类共 10 个项目**

### 1.2 推理框架与模型部署

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 163.0k | **ollama** | 本地运行大模型（Kimi, DeepSeek, Qwen 等） | [🔗](https://github.com/ollama/ollama) |
| 156.1k | **transformers** | Transformers 模型定义框架 | [🔗](https://github.com/huggingface/transformers) |
| 122.8k | **open-webui** | 用户友好 AI 界面（支持 Ollama） | [🔗](https://github.com/open-webui/open-webui) |
| 69.4k | **vllm** | 高性能 LLM 推理和服务引擎 | [🔗](https://github.com/vllm-project/vllm) |
| 51.6k | **unsloth** | 快速微调 LLM（提速 2 倍，显存减少 70%） | [🔗](https://github.com/unslothai/unsloth) |
| 41.5k | **DeepSpeed** | 微软深度学习优化库 | [🔗](https://github.com/deepspeedai/DeepSpeed) |
| 10.8k | **text-generation-inference** | HuggingFace TGI 推理引擎 | [🔗](https://github.com/huggingface/text-generation-inference) |

**该分类共 7 个项目**

### 1.3 Coding-Agent

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 107.2k | **opencode** | AnomalyCo 开源 Coding Agent | [🔗](https://github.com/anomalyco/opencode) |
| 94.9k | **gemini-cli** | Google Gemini CLI | [🔗](https://github.com/google-gemini/gemini-cli) |
| 67.8k | **claude-code** | Anthropic 官方 Coding Agent | [🔗](https://github.com/anthropics/claude-code) |
| 61.1k | **codex** | OpenAI 官方 Coding Agent | [🔗](https://github.com/openai/codex) |
| 32.4k | **oh-my-opencode** | opencode 最佳增强工具 | [🔗](https://github.com/code-yeongyu/oh-my-opencode) |
| 21.5k | **vibe-kanban** | 让 Claude Code/Codex 效率提升 10 倍 | [🔗](https://github.com/BloopAI/vibe-kanban) |

**该分类共 6 个项目**

### 1.4 低代码平台

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 128.6k | **dify** | LLM 应用开发平台 | [🔗](https://github.com/langgenius/dify) |
| 172.9k | **n8n** | 工作流自动化平台 | [🔗](https://github.com/n8n-io/n8n) |
| 54.2k | **anything-llm** | 一站式 AI 应用（RAG + Agent 构建器） | [🔗](https://github.com/Mintplex-Labs/anything-llm) |
| 122.8k | **open-webui** | 用户友好 AI 界面（支持 Ollama） | [🔗](https://github.com/open-webui/open-webui) |
| - | **coze** | 扣子 AI 应用平台 | [🔗](https://www.coze.cn/) |

**该分类共 5 个项目**

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
| 73.4k | **ragflow** | 开源 RAG 引擎 | [🔗](https://github.com/infiniflow/ragflow) |
| 31.0k | **graphrag** | 微软 GraphRAG | [🔗](https://github.com/microsoft/graphrag) |

#### 文档处理

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 54.5k | **MinerU** | 开源文档解析工具 | [🔗](https://github.com/opendatalab/MinerU) |

#### Vector-DB

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **milvus** | 开源向量数据库 | [🔗](https://github.com/milvus-io/milvus) |

### 2.3 Memory

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 47.6k | **mem0** | AI 应用的记忆层 | [🔗](https://github.com/mem0ai/mem0) |

### 2.4 通信协议

#### MCP (Model Context Protocol)

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 78.0k | **servers** | MCP 官方服务器集合 | [🔗](https://github.com/modelcontextprotocol/servers) |
| 80.3k | **awesome-mcp-servers** | MCP 服务器精选合集 | [🔗](https://github.com/punkpeye/awesome-mcp-servers) |
| 22.6k | **fastmcp** | 快速构建 MCP 服务器（Python） | [🔗](https://github.com/jlowin/fastmcp) |

#### A2A (Agent-to-Agent)

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **A2A** | Agent 间通信协议 | [🔗](https://github.com/a2aproject/A2A) |

#### ACP (Agent Client Protocol)

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **ACP** | Agent 客户端协议 | [🔗](https://agentclientprotocol.com/get-started/introduction) |

### 2.5 DeepResearch

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **DeepResearch** | 阿里 NLP 深度研究 | [🔗](https://github.com/Alibaba-NLP/DeepResearch) |

### 2.6 Skills

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **skills (anthropics)** | Anthropic Skills 官方 | [🔗](https://github.com/anthropics/skills) |
| - | **awesome-claude-skills** | Claude Skills 精选 | [🔗](https://github.com/ComposioHQ/awesome-claude-skills) |
| - | **skills (openai)** | OpenAI Skills 官方 | [🔗](https://github.com/openai/skills) |
| - | **spec-kit** | GitHub SDD 规范 | [🔗](https://github.com/github/spec-kit) |
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
| 27.9k | **ai-engineering-hub** | LLM、RAG 和 AI Agent 深度实战教程 | [🔗](https://github.com/patchy631/ai-engineering-hub) |
| 25.1k | **agents-course** | Hugging Face Agents 官方课程 | [🔗](https://github.com/huggingface/agents-course) |
| 23.2k | **llm-cookbook** | 面向开发者的 LLM 入门教程（吴恩达中文） | [🔗](https://github.com/datawhalechina/llm-cookbook) |
| 41.0k | **chatgpt-on-wechat** | 基于大模型的超级 AI 助理（多平台接入） | [🔗](https://github.com/zhayujie/chatgpt-on-wechat) |
| 23.2k | **llm-action** | 大模型实战项目集合 | [🔗](https://github.com/liguodongiot/llm-action) |

**该分类共 12 个项目，更多详见原文件**

### 3.2 书籍与笔记

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 36.2k | **Coursera-ML-AndrewNg-Notes** | 吴恩达机器学习课程笔记 | [🔗](https://github.com/fengdu78/Coursera-ML-AndrewNg-Notes) |
| - | **agentic-design-patterns-cn** | 《Agentic Design Patterns》中文版 | [🔗](https://github.com/ginobefun/agentic-design-patterns-cn) |
| - | **nndl.github.io** | 《神经网络与深度学习》邱锡鹏 | [🔗](https://github.com/nndl/nndl.github.io) |

### 3.3 学习项目

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 92.0k | **awesome-llm-apps** | 精选 LLM 应用合集（OpenAI, Anthropic, Gemini） | [🔗](https://github.com/Shubhamsaboo/awesome-llm-apps) |
| 24.4k | **500-AI-Agents-Projects** | 500 个 AI Agent 项目集合 | [🔗](https://github.com/ashishpatel26/500-AI-Agents-Projects) |
| 38.7k | **minimind** | 2 小时从 0 训练 26M 小参数 GPT | [🔗](https://github.com/jingyaogong/minimind) |
| 15.7k | **dexter** | 自主深度金融研究 Agent | [🔗](https://github.com/virattt/dexter) |
| 16.3k | **WeClone** | 从聊天记录创建数字分身 | [🔗](https://github.com/xming521/WeClone) |

---

*由于篇幅限制，以下章节简略展示。完整内容见仓库文件。*

## 四、评估与测试

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **ragas** | Agent/RAG 评估框架 | [🔗](https://github.com/vibrantlabsai/ragas) |

## 五、实用资源

### 5.5 金融与交易 AI

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| 45.6k | **ai-hedge-fund** | AI 对冲基金团队 | [🔗](https://github.com/virattt/ai-hedge-fund) |
| 59.8k | **OpenBB** | 金融数据平台（分析师、量化、AI Agent） | [🔗](https://github.com/OpenBB-finance/OpenBB) |
| 29.2k | **TradingAgents** | 多智能体 LLM 金融交易框架 | [🔗](https://github.com/TauricResearch/TradingAgents) |
| 18.6k | **FinGPT** | 开源金融大语言模型 | [🔗](https://github.com/AI4Finance-Foundation/FinGPT) |

---

## 六、开发实践

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **claude-cookbooks** | Anthropic 官方 Cookbook | [🔗](https://github.com/anthropics/claude-cookbooks) |
| - | **OpenAI Cookbook** | OpenAI Agents 专题 | [🔗](https://cookbook.openai.com/topic/agents) |
| - | **vibe-coding-cn** | Vibe Coding 中文资源 | [🔗](https://github.com/2025Emma/vibe-coding-cn) |

## 七、其他资源

| ⭐ | 名称 | 简介 | 链接 |
|---:|------|------|------|
| - | **openclaw** | 个人 AI 助手（跨平台） | [🔗](https://github.com/openclaw/openclaw) |
| - | **crawl4ai** | LLM 友好的开源网页爬虫 | [🔗](https://github.com/unclecode/crawl4ai) |
| - | **deepwiki** | AI 源码阅读工具 | [🔗](https://deepwiki.com/) |
| - | **datawhalechina** | Datawhale 开源社区 | [🔗](https://github.com/datawhalechina) |
| - | **anthropics** | Anthropic 官方 | [🔗](https://github.com/anthropics) |

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

---

*📅 更新时间: 2026-02-20*

*⭐ Stars 数据实时获取，按数量倒序排列*

*🤖 专注 Agent 开发工程师成长*
