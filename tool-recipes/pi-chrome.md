# pi-chrome Recipes

## Recipe: pi-chrome package update must be run from the system terminal

### Tool / Area

pi-chrome / Pi package update / Chrome bridge

### Error Signature

- `Package updates are available`
- `Packages: pi-chrome`
- The user types `pi update` inside the Pi chat interface
- Pi answers as a model instead of executing the command
- `/chrome onboard` behaves like normal chat instead of an extension command

### Symptoms

The `/chrome` command is not recognized, or Pi gives a natural-language answer instead of running the pi-chrome onboarding flow.

### Root Cause

The update command was entered inside the Pi conversation instead of the macOS system terminal. Pi package commands such as `pi update --extensions` must be run in the shell after exiting Pi.

### Verified Fix

1. Exit Pi:

```bash
/exit
```

or press `Ctrl+C`.

2. Run in macOS Terminal:

```bash
pi update --extensions
```

3. Restart Pi:

```bash
pi
```

4. Confirm pi-chrome is loaded:

```text
[Extensions]
  pi-chrome:chrome-profile-bridge
```

5. Then run:

```text
/chrome doctor
/chrome onboard
```

### Verification

The fix is verified if `/chrome doctor` is handled as a pi-chrome command, not as normal chat.

### When to Use Again

Use this recipe when `/chrome onboard` or `/chrome doctor` is treated like normal conversation, or when Pi reports a pending `pi-chrome` package update.

### When Not to Use

Do not use if `/chrome doctor` already works. In that case, the problem is likely Chrome extension pairing, Service Worker suspension, or browser authorization.

### Date Verified

2026-05-16
