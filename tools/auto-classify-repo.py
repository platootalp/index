#!/usr/bin/env python3
"""
自动分类 GitHub 仓库到 resources/ai-agent.md
根据仓库名称、描述和 topics 自动判断分类
"""

import json
import re
import sys
from urllib.request import urlopen
from urllib.error import HTTPError

# 分类规则（关键词匹配）
CATEGORIES = {
    "开发框架": {
        "keywords": ["framework", "sdk", "platform", "agent framework", "llm framework", "ai sdk"],
        "repos": ["langchain", "crewai", "agno", "n8n", "dify", "langgraph", "adk"]
    },
    "Coding-Agent": {
        "keywords": ["code", "coding", "claude code", "codex", "cursor", "ide", "editor", "programming assistant"],
        "repos": ["claude-code", "codex", "opencode", "gemini-cli", "superpowers"]
    },
    "推理框架": {
        "keywords": ["inference", "serving", "deployment", "ollama", "vllm", "transformers", "deepspeed"],
        "repos": ["ollama", "vllm", "transformers", "deepspeed", "unsloth", "text-generation"]
    },
    "RAG": {
        "keywords": ["rag", "retrieval", "embedding", "vector", "search", "knowledge base"],
        "repos": ["ragflow", "graphrag", "langchain", "llama-index", "chroma", "milvus"]
    },
    "MCP": {
        "keywords": ["mcp", "model context protocol"],
        "repos": ["mcp", "fastmcp", "modelcontextprotocol"]
    },
    "Memory": {
        "keywords": ["memory", "mem0", "zep", "recall", "remember"],
        "repos": ["mem0", "zep", "graphiti"]
    },
    "低代码平台": {
        "keywords": ["low-code", "no-code", "builder", "workflow", "drag", "ui builder"],
        "repos": ["anything-llm", "coze", "n8n"]
    },
    "学习路线": {
        "keywords": ["course", "tutorial", "learn", "education", "beginner", "guide", "examples", "sample"],
        "repos": ["course", "tutorial", "learn", "beginners", "examples", "cookbook"]
    },
    "书籍与笔记": {
        "keywords": ["book", "notes", "handbook", "cheatsheet", "lecture"],
        "repos": ["book", "notes"]
    },
    "评估与测试": {
        "keywords": ["eval", "benchmark", "test", "ragas", "evaluation"],
        "repos": ["ragas", "eval", "benchmark"]
    },
    "实用工具": {
        "keywords": ["tool", "utility", "crawler", "scraper", "cli", "automation"],
        "repos": ["crawl4ai", "scraper", "cli"]
    },
    "金融与交易 AI": {
        "keywords": ["finance", "trading", "stock", "crypto", "hedge", "investment", "portfolio"],
        "repos": ["trading", "finance", "hedge-fund", "stock", "crypto"]
    },
    "AI 媒体生成": {
        "keywords": ["video", "image", "audio", "media", "generation", "synthesis", "deepfake"],
        "repos": ["moneyprinter", "deep-live-cam", "video", "image"]
    },
    "学习项目": {
        "keywords": ["project", "demo", "app", "application", "implementation", "experiment"],
        "repos": ["awesome-llm-apps", "implementations", "from-scratch"]
    },
    "工程博客": {
        "keywords": ["cookbook", "blog", "engineering", "cookbooks", "paper"],
        "repos": ["cookbook", "engineering"]
    }
}

EXCLUDED_CATEGORIES = ["holiday", "calendar", "english-words", "landing", "ant-design"]

def get_repo_info(repo_full_name, token=None):
    """获取仓库信息"""
    url = f"https://api.github.com/repos/{repo_full_name}"
    headers = {}
    if token:
        headers["Authorization"] = f"Bearer {token}"

    try:
        req = urlopen(url)
        data = json.loads(req.read().decode())
        return {
            "name": data["name"],
            "full_name": data["full_name"],
            "description": data.get("description", ""),
            "stars": data["stargazers_count"],
            "language": data.get("language", ""),
            "topics": data.get("topics", []),
            "url": data["html_url"]
        }
    except HTTPError as e:
        if e.code == 404:
            print(f"❌ 仓库不存在: {repo_full_name}")
        elif e.code == 403:
            print(f"⛔ API 限流: {repo_full_name}")
        else:
            print(f"❌ 错误 {e.code}: {repo_full_name}")
        return None
    except Exception as e:
        print(f"❌ 获取失败: {repo_full_name} - {e}")
        return None

def classify_repo(repo_info):
    """根据信息自动分类"""
    name = repo_info["name"].lower()
    desc = (repo_info["description"] or "").lower()
    topics = [t.lower() for t in repo_info["topics"]]

    scores = {}

    for category, rules in CATEGORIES.items():
        score = 0

        # 检查 repo 名称匹配
        for repo_pattern in rules["repos"]:
            if repo_pattern in name:
                score += 10

        # 检查关键词匹配
        for keyword in rules["keywords"]:
            if keyword in name:
                score += 5
            if keyword in desc:
                score += 3
            if keyword in topics:
                score += 4

        if score > 0:
            scores[category] = score

    # 检查是否属于 AI-Agent 相关
    ai_keywords = ["ai", "agent", "llm", "language model", "gpt", "claude", "automation", "openai"]
    ai_score = 0
    for kw in ai_keywords:
        if kw in name or kw in desc:
            ai_score += 1

    # 检查排除项
    for exclude in EXCLUDED_CATEGORIES:
        if exclude in name.lower() or exclude in desc.lower():
            return None, "非 AI-Agent 相关"

    if ai_score == 0 and not scores:
        return None, "非 AI-Agent 相关"

    if scores:
        best_category = max(scores, key=scores.get)
        return best_category, scores[best_category]

    return "其他资源", 0

def format_stars(count):
    """格式化 stars 数字"""
    if count >= 1000:
        return f"{count/1000:.1f}k".replace(".0k", "k")
    return str(count)

def generate_markdown(repo_info, category):
    """生成表格行 Markdown"""
    stars = format_stars(repo_info["stars"])
    desc = repo_info["description"] or "暂无描述"
    desc = desc[:50] + "..." if len(desc) > 50 else desc

    return f"| {stars} | **{repo_info['name']}** | {desc} | [🔗]({repo_info['url']}) |"

def main():
    if len(sys.argv) < 2:
        print("用法: python3 auto-classify-repo.py <repo-full-name> [github-token]")
        print("示例: python3 auto-classify-repo.js anthropic/claude-code ghp_xxxx")
        sys.exit(1)

    repo_name = sys.argv[1]
    token = sys.argv[2] if len(sys.argv) > 2 else None

    print(f"🔍 分析仓库: {repo_name}")

    repo_info = get_repo_info(repo_name, token)
    if not repo_info:
        sys.exit(1)

    print(f"📊 信息: {repo_info['stars']} ⭐ | {repo_info['language']} | {repo_info['description'][:60]}")

    category, score = classify_repo(repo_info)

    if category is None:
        print(f"❌ 跳过: {score}")
        sys.exit(0)

    print(f"✅ 分类: {category} (置信度: {score})")

    md_line = generate_markdown(repo_info, category)
    print(f"\n📝 Markdown 行:")
    print(md_line)

    # 输出分类结果供脚本使用
    print(f"\n🏷️  CATEGORY:{category}")

if __name__ == "__main__":
    main()
