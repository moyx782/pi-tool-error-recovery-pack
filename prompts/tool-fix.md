---
description: Handle a tool failure by searching verified recipes, trying safe fixes, and saving successful verified fixes.
argument-hint: "<tool error or command failure>"
---

# Tool Fix Mode

User issue:

$ARGUMENTS

Only use this mode for tool, command, package, MCP, browser, extension, or integration errors.

Workflow:

1. Identify tool name, command, and error signature.
2. Search:

```bash
rg -i "<tool>|<command>|<error keyword>" ~/.pi/agent/tool-recipes
```

3. If a matching recipe exists, read it and try the safe fix.
4. If no recipe exists, ask the user how to handle it.
5. Try the user's method.
6. If it works, save a verified recipe under `~/.pi/agent/tool-recipes/`.
7. Do not save secrets, tokens, cookies, passwords, or private account data.

End with:

- Problem:
- Recipe search:
- Fix attempted:
- Verification:
- Recipe saved:
- Next time:
