---
name: tool-error-recovery
description: Use this skill when a tool, shell command, package manager, MCP server, browser bridge, Pi extension, Chrome extension, npm package, GitHub integration, or external tool fails, or before using a tool that may have known setup issues. This skill searches verified tool recipes, applies safe fixes, asks the user when no recipe exists, and saves successful verified fixes.
---

# Tool Error Recovery Skill

## Purpose

This skill handles tool usage errors and reusable tool setup problems.

Use this skill only when:

- A tool call fails
- A shell command fails
- A Pi extension command fails
- An MCP server fails
- A browser / Chrome / CDP / Playwright integration fails
- npm / node / package manager behavior fails
- A GitHub / API / external integration fails
- The agent is about to use a tool that may have known setup issues

Do not use this skill for normal conversation, normal coding reasoning, or ordinary explanations.

---

## Recipe Store

Verified tool recipes are stored in:

```text
~/.pi/agent/tool-recipes/
```

If the directory does not exist, create it:

```bash
mkdir -p ~/.pi/agent/tool-recipes
```

---

## Core Workflow

When a tool or command fails:

1. Extract the failure context:
   - Tool name
   - Command or action
   - Error message
   - Exit code
   - Package / extension / integration name
   - Environment if visible

2. Search existing verified recipes:

```bash
rg -i "<tool>|<command>|<package>|<main error keyword>|<exit code>" ~/.pi/agent/tool-recipes/
```

3. If a matching recipe exists:
   - Read the recipe.
   - Check whether it really matches the current error.
   - Apply the fix only if it is safe.
   - Verify the result.

4. If no matching recipe exists:
   - Ask the user how to handle it.
   - Wait for the user's method.
   - Try the user's method with minimal safe adaptation.
   - Verify whether the method worked.

5. If the method worked:
   - Automatically create or append a verified recipe.
   - Save only reusable technical information.
   - Do not save secrets or one-time temporary facts.

6. If the method failed:
   - Do not save a recipe.
   - Summarize what was tried and ask for the next method.

---

## Before Using a Tool

Before using a tool that may have known setup issues, search the recipe store quickly.

Examples:

```bash
rg -i "pi-chrome|chrome|onboard|doctor" ~/.pi/agent/tool-recipes/
rg -i "npm|node|gradle|java|jdk" ~/.pi/agent/tool-recipes/
rg -i "github-mcp|mcp|github" ~/.pi/agent/tool-recipes/
```

If a relevant recipe exists, use it as prior guidance.

If no recipe exists, continue normally.

---

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

Use lowercase names with hyphens.

---

## Recipe Format

When saving a recipe, use this format:

```md
## Recipe: <short title>

### Tool / Area

<tool name, package, extension, or integration>

### Error Signature

<stable phrases, command, exit code, or symptoms that identify this error>

### Symptoms

<what the user or agent sees>

### Root Cause

<why it happened, if known>

### Verified Fix

<steps that solved the problem>

### Verification

<command, tool check, doctor command, test, or observed result proving it worked>

### When to Use Again

<conditions where this recipe should be reused>

### When Not to Use

<similar cases where this fix may be wrong>

### Date Verified

<YYYY-MM-DD>
```

---

## Verification Rule

A recipe is verified only if the fix was actually tried and worked.

Valid verification examples:

```text
/chrome doctor works
pi list shows the extension
npm run dev starts successfully
npm test passes
command exits with code 0
tool call succeeds
browser bridge connects
MCP server lists tools
```

Do not save untested guesses.

---

## Safety Rules

Never save:

- passwords
- API keys
- tokens
- cookies
- private credentials
- payment data
- private account data
- one-time personal information

Always ask before:

- deleting files
- running `sudo`
- running `rm -rf`
- modifying system directories
- git commit / git push
- deployment
- publishing packages
- external account changes
- submitting forms through logged-in browser sessions

---

## Output Format

When using this skill, respond with:

```md
## Tool Error Recovery

### Error Detected

### Recipe Search

### Matched Recipe

### Action Taken

### Verification

### Saved Recipe

### Next Time
```

If no recipe is saved, write:

```text
Saved Recipe: Not saved because the fix was not verified.
```

---

## Example Search

For a pi-chrome command issue:

```bash
rg -i "pi-chrome|chrome onboard|chrome doctor|extension command" ~/.pi/agent/tool-recipes/
```

For npm / node issue:

```bash
rg -i "npm|node|package.json|missing script|EBADENGINE" ~/.pi/agent/tool-recipes/
```

For MCP issue:

```bash
rg -i "mcp|github-mcp|toolsets|server failed|connection refused" ~/.pi/agent/tool-recipes/
```
