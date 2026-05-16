# pi-tool-error-recovery-pack

A minimal **Pi Agent skill + recipe pack** for recovering from tool and command failures.

## Pack contents

- `pack.json` - top-level manifest linking skills and recipes.
- `skills/tool-error-recovery/skill.json` - skill metadata, triggers, and execution contract.
- `recipes/tool-error-recovery/recipe.json` - deterministic recovery flow for tool/command errors.

## What it does

The pack activates when a tool call or shell command fails and guides Pi Agent to:

1. classify the error,
2. collect actionable diagnostics,
3. choose a safe retry/fallback,
4. run recovery steps, and
5. report outcome and next actions.

## Intended integration

Load `pack.json` in your Pi Agent runtime, then dispatch errors to recipe
`recipe.tool_error_recovery.v1` when a tool/command execution failure is detected.
