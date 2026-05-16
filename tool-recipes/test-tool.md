# Test Tool Recipes

## Recipe: PI_RECIPE_TEST_ERROR safe recovery

### Tool / Area

test-tool / shell command test

### Error Signature

PI_RECIPE_TEST_ERROR

### Symptoms

A command prints `PI_RECIPE_TEST_ERROR` and exits with a non-zero status.

### Root Cause

This is an intentional fake error used to test whether Pi searches tool-recipes after a tool failure.

### Verified Fix

Do not retry the failed command.

Instead, print this exact message:

```text
RECIPE_MATCHED_AND_APPLIED
```

### Verification

The test passes if Pi finds this recipe and outputs:

```text
RECIPE_MATCHED_AND_APPLIED
```

### When to Use Again

Use this only when testing the Tool Error Recovery Rules.

### When Not to Use

Do not use this for real shell errors.

### Date Verified

2026-05-16
