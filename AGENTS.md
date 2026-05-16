# Pi Agent Tool Error Recovery Rules

## Tool Error Recovery Trigger

When a tool, command, package manager, MCP server, browser bridge, Pi extension, Chrome extension, npm package, GitHub integration, or external integration fails, use the `tool-error-recovery` skill.

If the agent is about to use a tool that may have known setup issues, search `~/.pi/agent/tool-recipes/` first or use the `tool-error-recovery` skill.

Do not use this process for normal conversation.

## Recipe Location

Verified tool recipes are stored in:

```text
~/.pi/agent/tool-recipes/
```

## Minimal Recovery Flow

When a tool fails:

1. Extract:
   - tool name
   - command or action
   - error message
   - exit code
   - package / extension / integration name

2. Search existing recipes:

```bash
rg -i "<tool name>|<command>|<error keyword>|<exit code>" ~/.pi/agent/tool-recipes/
```

3. If a matching recipe exists:
   - read it
   - apply the safe fix
   - verify the result

4. If no recipe exists:
   - ask the user how to handle it
   - try the user's method
   - if it works, automatically create or append a verified recipe

## Auto-create Recipe Rule

If no matching recipe exists, and the user gives a method that works, create or append a recipe automatically.

Choose file names like:

```text
pi-chrome.md
npm-node.md
github-mcp.md
browser-cdp.md
playwright.md
mcp.md
shell.md
macos.md
windows.md
misc.md
```

Only save a recipe if:

1. The original error was observed.
2. The user provided or approved the fix method.
3. The agent tried the fix.
4. The fix worked.
5. The recipe does not contain secrets, tokens, cookies, API keys, passwords, payment information, or private account data.

## Safety

Never save:

- passwords
- tokens
- cookies
- API keys
- private credentials
- payment information
- private account data

Ask before:

- deleting files
- running sudo
- running rm -rf
- git commit / git push
- deployment
- publishing
- external account changes
- submitting forms through logged-in browser sessions
