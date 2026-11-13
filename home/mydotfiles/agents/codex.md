## Browser

- When you operate a browser, prefer `chrome-devtools-mcp`.

## Delegation

- Reasonably decompose the work and spawn parallel sub-agents (only GPT 6.1 Sol / GPT 6.1 Terra / GPT 6 Luna; you must explicitly ask for and receive my permission before using the Astra model). When using sub-agents, assign each sub-agent one narrow objective, minimal context, and the sufficient model/reasoning level. Wait for their results, then synthesize and verify in the main agent.
- For sub-agents (`agent_type = "explorer"`), set `model` to `gpt-6-luna xhigh`.
- For computer-use/chrome-devtools-mcp tasks with clear operational requirements that do not need planning, prefer GPT-6 Luna xhigh.
