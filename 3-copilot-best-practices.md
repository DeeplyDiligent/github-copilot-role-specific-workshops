---
marp: true
theme: default
paginate: true
---
<style>section { font-size: 20px; margin-top:-50px}</style>

# Advanced GitHub Copilot Business Use Cases and Best Practices

**Overview:** GitHub Copilot Business equips teams with enterprise-grade AI coding assistance, including **Copilot Chat**, **Agent Mode**, and advanced management features.  This tier enables centralized policy control and specialized tools while keeping developers in control. Below, we explore practical use cases and tips—particularly for .NET (C#), Java, and React developers—covering everything from autonomous code generation to CI/CD automation.

---

## Copilot Agent Mode – Autonomous Multi-step Coding  
- **What it does:** Copilot’s *Agent Mode* acts as an “autonomous peer programmer” that can handle complex tasks across multiple files.  It can **create entire applications from scratch**, refactor codebase-wide, write and run tests, migrate legacy code, or integrate new libraries—simply by following a natural-language prompt.  Under the hood it “loops” through planning, editing, running commands, and fixing errors until the job is done.  
- **Example use cases:** For example, you can ask the agent to “build a CRUD API in C# with Entity Framework and Swagger docs,” and it will analyze your project structure, generate models/controllers, run database migrations, and even fix any compilation errors automatically.  Developers report using agent mode for tasks from “autofixing code-gen errors” to “building webapps” in one shot.  
- **Tooling & Models:** Agent Mode in VS Code supports multiple models (Claude, Gemini, GPT-4o, etc.) and now includes Model Context Protocol (MCP) support.  This means agents can call external tools or query your repositories (e.g. via a new open-source MCP server) to access database schemas, run searches, or manage GitHub issues as part of their workflow.  
- **Getting Started:** In VS Code (Insiders or latest stable), switch to **Agent** mode in the Copilot pane and type your goal.  You may be prompted to authorize tool calls.  Agent Mode is evolving rapidly; enable it in settings to experiment with multi-step fixes and scaffolding.  

---

## Copilot Workspace – An AI-Native Dev Environment  
- **Natural-language tasks:** Copilot Workspace (Tech Preview) transforms tasks like issues or PRs into AI-driven workflows.  Describe what you want in plain English—whether “add a new feature” or “fix this bug”—and the **plan agent** will propose a step-by-step plan and implement it.  
- **Iterative brainstorming:** Use the **brainstorm agent** to discuss and refine ideas inline.  Workspace is designed for fast iteration: you can regenerate or undo parts of the solution instantly.  This is useful when exploring UI changes (e.g. adjusting a React component layout) or tuning service logic (e.g. changing an algorithm).  
- **Integrated testing and repair:** Workspace includes an integrated terminal and a **repair agent**.  After the agent makes changes, run your tests and let the repair agent automatically fix any test failures based on error messages.  You can also open a Codespace for full debugging if needed.  
- **Collaboration & PRs:** Workspaces are shareable by default.  When ready, share the workspace URL with teammates for feedback, or create a real GitHub pull request with one click.  Copilot Workspace automatically versions the context/history of your changes, so reviewers see exactly what prompts and edits were used.  (Any PR created will list you as the author.)  
- **Anywhere access:** Even from the GitHub mobile app you can open issues or PRs directly in Copilot Workspace to prototype changes on the go.  

---

## Prompt Engineering & Context Management (P1) 
- **Provide rich context:** Always work with relevant files open.  Copilot uses the open files in your editor to infer context and craft prompts.  In Copilot Chat, use special keywords: e.g. `#editor` to include all open files or `#workspace` to include the entire repository as context.  This ensures Copilot sees your project structure, types, and existing functions when generating code.  
- **Write top-level comments:** In a blank/new file or when starting a feature, write a high-level comment or docstring describing your goal and requirements.  For example, “Create a basic React component that fetches and displays user data…” with bullet points for props, hooks, and libraries.  This “big picture” prime helps Copilot generate complete boilerplate code.
---
## Prompt Engineering & Context Management (P2)  
- **Be specific and stepwise:** Break complex tasks into smaller prompts.  Think of it as writing a recipe: give Copilot a high-level goal, then add specific sub-tasks (e.g. “Then format the date using `toLocaleDateString()`”).  Short, focused instructions produce better results.  You can also refine step by step (e.g. reverse a string by prompting each transformation in turn).  
- **Use meaningful names:** Meaningful identifiers help Copilot infer intent.  Rename generic names like `foo`/`bar` to descriptive ones (`fetchAirports`, `calculateTotal`) so the AI knows what you’re trying to do.  This leads to more accurate completions (garbage-in leads to garbage-out).  
- **Specify imports and versions:** Pre-add `using` or `import` statements for libraries and frameworks you want to use.  If Copilot suggests older API calls, ensure the right package version is referenced in your file so it generates up-to-date code.  
- **Take advantage of Chat skills:** Copilot Chat (in IDE or GitHub) has built-in skills and personas.  For example, you can prefix a query with “You are a senior Java developer…” to guide its style.  Use keywords like `#editor`, `#issue`, `#pull-request` to define the context of your question.  Copilot Chat can also adopt personas for code reviews or optimizations.  

---

## Language & Framework Patterns  

- **.NET (C#):** Copilot is very effective at common .NET patterns.  It can generate LINQ queries, async methods, and ASP.NET Core controllers from comments.  For example, in C# you can comment “POST endpoint to create a new Customer in CustomerController” and Copilot will scaffold the method signature and body.  It also knows common .NET types (e.g. `Task<T>`, `IQueryable`) so ensure those types are in context.  Copilot Chat or `/tests` can produce xUnit or NUnit test stubs for your C# methods.  When upgrading framework versions (say .NET 5→6), ask Copilot to fix compile errors and suggest replacements (it can suggest updated syntax or package changes).  
- **Java:** Similarly, Copilot handles Java idioms (Spring Boot, Jakarta EE, etc.).  Write high-level comments like “Service class to fetch orders from database using Spring Data JPA” and Copilot will generate the repository interface and service code.  Use Chat to get JUnit test methods for your Java classes (`/tests` on a selected method works for Java too).  Copilot can refactor Java code (e.g. convert loops to streams) or explain complex legacy code when onboarding.  
- **React / Frontend:** Copilot excels with JavaScript/TypeScript.  Describe the component you need and it will create JSX/TSX scaffolding.  For example, a prompt “Build a React hook form with email/password fields and validation” yields a complete `useState`/`onSubmit` handler using a validation library.  Use Copilot Chat to choose UI libraries (e.g. “suggest a popular chart library for React” and it may recommend Chart.js or Recharts).  It can automatically suggest CSS class names or aria-labels to improve accessibility.  In a React prototype example, Copilot Chat helped create UIs, troubleshoot rendering errors, and generate Jest unit tests.  

---

## Testing, Documentation and Refactoring  
- **Unit/integration tests:** Quickly generate tests by selecting code blocks and using the `/tests` command or right-click menu in the editor.  Copilot will propose valid inputs and edge-case assertions.  For failing tests, use `/fixTestFailure` or `/fix` to let Copilot suggest corrections for broken code.  This works for C#, Java, JS, and more.  Always review and adapt the suggested tests.  
- **Documentation and code explanation:** Ask Copilot to explain a function or API in your code.  For example, selecting a complex method and using `/explain` makes Copilot describe what the code does line-by-line.  This is invaluable for onboarding or translating old code.  After explanation, you can prompt Copilot to generate Javadoc, XML comments, or markdown docs for that code snippet.  
- **Refactoring suggestions:** Copilot can suggest refactoring opportunities.  For instance, it can help rename methods, extract functions, or simplify logic.  You might ask “Can you refactor this loop to use LINQ?” or “Make this React component more reusable.” The agent mode can even perform multi-file refactors automatically.  In PRs, the **next edit suggestions** feature will hint at further improvements inline (e.g. optimize an expression) while you code.  

---

## CI/CD, DevOps and Infrastructure-as-Code  
- **GitHub Actions / CI Pipelines:** Use Copilot to write GitHub Actions YAML or Azure Pipeline definitions.  For example, start a workflow file with a description (on push to main, run .NET build) and Copilot will suggest the rest of the YAML steps.  It knows common actions (checkout, setup-dotnet, actions/upload-artifact) and can adjust to your languages.  You can also ask Copilot Chat for best-practice CI steps, e.g. code coverage or Sonar scanning integration.  
- **Infrastructure-as-Code:** Copilot can scaffold Terraform or CloudFormation configurations.  Given a prompt like “Create a Terraform module for an AWS VPC with public and private subnets,” it will write the `main.tf`, `variables.tf`, etc.  Similarly, you might describe a Kubernetes deployment, and Copilot will output a `deployment.yaml`.  Always validate with your cloud provider’s tools.  
- **DevOps CLI assistance:** The **GitHub CLI Copilot extension** (`gh copilot`) lets you ask for command suggestions.  For example, `gh copilot suggest "Deploy Docker image to Kubernetes"` might walk through `kubectl apply` or `gh` commands.  `gh copilot explain` followed by a shell command describes it in plain language. This is handy for newcomers to DevOps tasks.  
- **Commit messages & PR summaries:** Copilot can help craft commit messages or PR descriptions.  For instance, describe the diff in natural language and ask Copilot to write a concise summary.  (Note: Copilot suggests code, but commit message generation can ensure your intent is well captured).  Also use the built-in **Pull Request Summary** to auto-generate PR descriptions from diff and issue context.  

---

## Code Review and Collaboration  
- **Copilot Code Review:** Copilot can act as an automated reviewer on pull requests.  When added as a reviewer, it provides feedback comments and suggested changes for your code.  It supports C, C#, C++, Go, Java, JavaScript, Kotlin, Python, and more, so it works for our .NET and Java stacks.  You can even give it “coding guidelines” (in plain text) and it will enforce those when reviewing.  Business tier includes this feature (subject to monthly quotas).  
- **Coding guidelines:** Use organization-wide coding guidelines (plain-English rules) to steer Copilot. For example, you can tell Copilot to follow a certain style (e.g. naming conventions, unit test structure) and the assistant will attempt to comply. This helps maintain consistency across teams.  
- **Pair programming & learning:** Treat Copilot Chat as a pair programmer. Ask open-ended questions (“How can I optimize this SQL query?”) to get insight. Use chat to browse docs or StackOverflow suggestions on the fly.  When stuck, you can paste snippets and ask Copilot to compare versions or point out inefficiencies.  

---

## Customization with MCP and Extensions  
- **Model Context Protocol (MCP):** GitHub’s MCP (now in public preview) acts like a “USB-C port for AI”.  With MCP, you can connect Copilot to custom data sources or tools. For example, you might fine-tune Copilot Chat on your private repositories, or add tools that parse your specific file formats.  The new open-source GitHub MCP Server lets you run MCP locally, customizing tool behaviors and enabling Copilot to, say, query your private issue tracker or documentation.  Advanced users can even set up private GPT-like models or RAG retrieval over in-house docs via MCP.  
- **Custom instructions & extensions:** Business tier supports **repository/personal custom instructions** and (preview) **organization-wide instructions**.  Use these to encode your team’s norms (e.g. “Always use `async` methods where possible” or “Prefer FluentAssertions in tests”) and Copilot will adapt suggestions.  Copilot also allows **prompt files** (pinned templates) and **private extensions**.  You can write a Copilot Extension (using GitHub Apps) to give Copilot new agents or skills tailored to your workflow. For instance, a “code search” agent that uses your own code search API.  
- **Quality policies:** Business admins can enforce policies like blocking code that closely matches public repositories and excluding sensitive files from suggestions.  Audit logs track Copilot usage across the organization.  These features help meet compliance and security requirements.

---

## IDE and Environment Tips  
- **VS Code (and Visual Studio) tips:** In VS Code, install the Copilot extension and stay on the latest release to access new features (Agent Mode, next-edit suggestions, multiple model selection).  Use **Tab** to accept suggestions, or the Copilot pane to view alternatives.  The Copilot CLI (`gh copilot`) also works in VS Code’s terminal.  In Visual Studio 2022/2023 (with the Copilot extension), you have similar inline completions and chat.  Use the chat panel or right-click “Copilot” to ask questions about your code.  
- **JetBrains IDEs:** The GitHub Copilot plugin is available for IntelliJ, Rider, etc.  It provides inline code suggestions and a chat window.  The feature set tracks VS Code closely, but as of 2025 JetBrains may lag slightly (for example, Agent Mode is first released on VS Code).  Still, you can accept or reject suggestions (often via Alt+Enter) and use Copilot chat in WebStorm/PyCharm.  Ensure you’re on the compatible IDE version as listed in the docs.  
- **Context windows:** All IDEs have a limit on how much code context they send.  For very large files or projects, consider summarizing or focusing the prompt to key sections.  You can also open multiple editor tabs with related files to expand context.  

---

## Productivity and Style Best Practices  
- **“Rubber duck” comments:** Even if you only want a code stub, writing a clear comment is like explaining your needs to a pair programmer.  Copilot excels when you treat prompts as part of the conversation.  
- **Iterate and review:** Treat AI suggestions as draft output.  Always read through Copilot’s code.  Use your IDE’s refactoring tools or linters on suggestions.  Remember: Copilot follows **your** context and prompt, so double-check for logic or security issues.  
- **Use linting and tests:** Integrate code scanners (SonarQube, CodeQL) and linters.  After applying Copilot’s suggestions, run your normal tests and security checks.  Copilot can catch many errors, but it can also introduce subtle bugs if the prompt was vague. Automated tests and code reviews remain essential.  
- **Collaborate with Copilot:** In team settings, document when you use Copilot in PR descriptions. Encourage teammates to try your Copilot Workspace or ask questions in Copilot Chat.  You can also ask Copilot to summarize code changes or to suggest relevant documentation links.  
- **Stay updated:** Copilot is evolving quickly.  Keep an eye on the GitHub Changelog and docs.  Features like **Next Edit Suggestions**, **MCP**, **new AI models** (Claude/Gemini/OAI) and **premium requests** are periodically added.  Enabling “Use latest Alpha” in VS Code Settings can expose preview features early.

---

## Security and Code Quality Considerations  
- **Guard against public code copying:** The Business plan allows blocking suggestions that match existing public code.  Enable this if licensing or IP is a concern.  Copilot also tags suggestions that resemble public code, so review those carefully.  
- **Do not expose secrets:** Never prompt Copilot with private tokens or keys.  Copilot is trained not to output credentials, but as a rule, keep secrets out of your code before AI runs. Use environment variables or CI secret management instead.  
- **Check for vulnerabilities:** Copilot suggestions may inadvertently introduce insecure code (e.g. outdated libraries).  Use GitHub’s code scanning (SAST) on AI-generated code.  Ask Copilot Chat to “find security issues in this code” as a sanity check.  
- **Custom linting guidelines:** As shown above, incorporate coding standards (via Copilot’s review guidelines or your linter) so Copilot learns the style you expect.  This improves consistency and reduces churn in PR reviews.  