# Pi Tool Error Recovery Pack

A lightweight **Pi Agent skill + recipe system** for recovering from tool, command, package, MCP, browser, and extension errors.

It makes Pi follow this workflow only when tools or commands fail:

```text
tool fails
-> search ~/.pi/agent/tool-recipes/
-> if recipe exists, apply safe fix
-> if no recipe exists, ask the user
-> try the user's method
-> if verified successful, save a new recipe
-> reuse it next time
```

## What This Adds

- `tool-error-recovery` skill
- `/tool-fix` prompt command
- `tool-recipes/` verified recipe store
- `AGENTS.md` trigger rules
- macOS/Linux install script
- Example recipes for `pi-chrome` and safe testing

## File Structure

```text
.
├── AGENTS.md
├── LICENSE
├── README.md
├── install.sh
├── prompts/
│   └── tool-fix.md
├── skills/
│   └── tool-error-recovery/
│       ├── SKILL.md
│       └── references/
└── tool-recipes/
    ├── README.md
    ├── pi-chrome.md
    └── test-tool.md
```

## Install

From this repository root:

```bash
chmod +x install.sh
./install.sh
```

Then inside Pi:

```text
/reload
```

## Manual Install

Copy files into:

```text
~/.pi/agent/
  AGENTS.md
  skills/tool-error-recovery/SKILL.md
  prompts/tool-fix.md
  tool-recipes/
```

If you already have `~/.pi/agent/AGENTS.md`, append this repository's `AGENTS.md` content instead of replacing your existing file.

## Usage

Manual trigger:

```text
/skill:tool-error-recovery <tool error>
```

or:

```text
/tool-fix <tool error>
```

Automatic behavior:

When a tool or command fails, Pi should search recipes first, apply a matching safe fix if one exists, or ask the user for a method when no verified recipe exists.

## Test

Inside Pi, ask:

```text
Please test Tool Error Recovery Rules.

Please use shell to run:

bash -lc 'echo PI_RECIPE_TEST_ERROR >&2; exit 42'

If the command fails, follow AGENTS.md: search ~/.pi/agent/tool-recipes/, find the matching recipe, and apply it.
```

Expected output:

```text
RECIPE_MATCHED_AND_APPLIED
```

## Safety

Recipes must not store:

- passwords
- tokens
- cookies
- API keys
- private credentials
- payment information
- private account data

The skill should ask before destructive or external actions such as:

- `sudo`
- `rm -rf`
- deleting many files
- `git push`
- deployment
- publishing
- submitting forms through logged-in browser sessions

## License

MIT
