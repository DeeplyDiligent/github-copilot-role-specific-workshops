---
marp: true
theme: default
paginate: true
footer: "GitHub Copilot Demo Guide"
---

# 🔍 GitHub Copilot Advanced Features – Demo Guide

Explore the capabilities of GitHub Copilot that go beyond code completion. Use this guide to showcase the most impactful features in your next demo session.

---

# ✨ 1. AI-Powered Code Suggestions

> **Best for:** Demonstrating seamless in-editor productivity boosts.

- **Inline Code Completions**: Real-time suggestions for code, comments, tests, and more.
- **Partial Acceptance**: Accept only the next word or next line instead of the full suggestion.
- **Alternative Suggestions**: Choose from multiple completions for flexibility.
- **Suggestions from Comments**: Write a comment like `// generate a for-loop` to trigger Copilot guidance.
- **Refactoring Help**: Rename variables project-wide or adjust copied code to match style.

---

# 💬 2. Natural Language Chat

> **Best for:** Showing intuitive interactions between developer and Copilot.

- **Multi-turn Chat**: Ask questions, get follow-ups, stay in context.
- **Ask Mode**: Learn about your codebase, concepts, or general coding topics.
- **Edit Mode (Copilot Edits)**: Describe code changes in plain English—Copilot edits across files.
- **Voice Interactions**: Dictate prompts via voice for hands-free coding.
- **Chat History Management**: Track and reuse previous sessions.

---

<style scoped>section { font-size: 20px; }</style>

# 🚀 3. Agents & Multi-Step Code Planning (⭐)

> **Best for:** Showing Copilot's ability to *think, plan, and act autonomously*.

## 👨‍💻 Agent Mode
- Define high-level goals like _“create a new python flask app that can generate QR codes in the py_website folder. make sure to structure your folders correctly”_.
- Copilot creates and executes a plan across files and tools.
- Automatically invokes edits, runs commands, and iterates.

## 🔧 Custom MCP Tools & Agents
- Build your own tools Copilot Agents can use.
- Extend functionality for unique workflows or tech stacks.

_💡 Tip: Show off an Agent completing a multi-file task from a single natural language prompt._

---

# 🧠 4. Context Awareness & Prompt Control

> **Best for:** Tailoring suggestions to real-world codebases.

- **Automatic Context Discovery**: Use `#codebase` to auto-include relevant files.
- **Manual Context Inclusion**: Use `#file`, `#selection`, `#problems`, etc.
- **Fetch Web Content**: Use `#fetch` to pull in context from a URL.
- **Workspace Indexing**: Fast search across remote or local projects.

---

# 🔧 5. Smart Actions in the Editor

> **Best for:** Productivity-focused demos inside VS Code.

- **Generate Commit Messages**
- **Pull Request Titles & Descriptions**
- **Rename Symbols with Suggestions**
- **Generate Inline Docs**
- **Generate Tests** (unit, integration, end-to-end)
- **Code Reviews** (quick or deep)
- **Semantic Search**: Find meaning-based matches, not just text.
- **Scaffold Projects/Files**: Use `/new` to spin up new code quickly.
- **Generate Notebooks**: Use `/newNotebook` to create Jupyter notebooks.

---

# 🧩 6. Slash Commands & Chat Enhancements

> **Best for:** Fast, task-specific Copilot interactions.

- `/explain`, `/fix`, `/tests`, `/startDebugging`, `/new`, etc.
- Use **chat variables** like `#file`, `#selection`, or `#VSCodeAPI` to add structured context.
- Interact with **chat participants**:
  - `@workspace` – Ask about files/project
  - `@vscode` – Ask about VS Code settings/extensions
  - `@terminal` – Get help with shell commands
  - `@github` – PRs, issues, workflows

---

# 🧪 7. Experimental & Extensible Features

> **Best for:** Showing what’s possible with advanced or team-specific setups.

- **Custom Instructions**: Configure in `.github/copilot-instructions.md` to match team style.
- **Reusable Prompt Files**: Store task-specific prompts in `.prompt.md` to reuse/share.
- **Language Model Selection**: Choose from fast/lightweight or more advanced LMs.
- **Extend with APIs**:
  - Build custom actions, tools, and chat integrations.
  - Integrate Copilot deeply into your dev workflow.

---

# 🛠️ 8. Debugging & Fixes

> **Best for:** Showing how Copilot can help after things break.

- **Debug Config Suggestions**
- **Inline Fixes** with `/fix` or Code Actions
- **Help with Test Failures or Lint Errors**

---

# 🖼️ 9. Vision (Preview)

> **Best for:** Advanced demos or future-looking capabilities.

- Add screenshots/images to chat prompts.
- Ask questions about visual content (great for UI bugs).

