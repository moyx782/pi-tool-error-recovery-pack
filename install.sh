#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PI_AGENT_DIR="${HOME}/.pi/agent"

mkdir -p "${PI_AGENT_DIR}/skills/tool-error-recovery"
mkdir -p "${PI_AGENT_DIR}/prompts"
mkdir -p "${PI_AGENT_DIR}/tool-recipes"

# Install skill
cp "${SRC_DIR}/skills/tool-error-recovery/SKILL.md" "${PI_AGENT_DIR}/skills/tool-error-recovery/SKILL.md"

# Install prompt
cp "${SRC_DIR}/prompts/tool-fix.md" "${PI_AGENT_DIR}/prompts/tool-fix.md"

# Install recipes without overwriting user files unless they do not exist.
for file in "${SRC_DIR}"/tool-recipes/*.md; do
  name="$(basename "$file")"
  target="${PI_AGENT_DIR}/tool-recipes/${name}"
  if [[ ! -f "$target" ]]; then
    cp "$file" "$target"
  else
    echo "Keeping existing recipe: $target"
  fi
done

# Append AGENTS rules safely.
AGENTS_TARGET="${PI_AGENT_DIR}/AGENTS.md"
MARKER_BEGIN="<!-- BEGIN PI TOOL ERROR RECOVERY PACK -->"
MARKER_END="<!-- END PI TOOL ERROR RECOVERY PACK -->"

if [[ ! -f "$AGENTS_TARGET" ]]; then
  touch "$AGENTS_TARGET"
fi

if grep -q "$MARKER_BEGIN" "$AGENTS_TARGET"; then
  echo "AGENTS.md already contains Tool Error Recovery Pack rules. Skipping append."
else
  {
    echo ""
    echo "$MARKER_BEGIN"
    cat "${SRC_DIR}/AGENTS.md"
    echo "$MARKER_END"
  } >> "$AGENTS_TARGET"
fi

echo "Installed Pi Tool Error Recovery Pack."
echo ""
echo "Next step inside Pi:"
echo "  /reload"
echo ""
echo "Manual trigger:"
echo "  /skill:tool-error-recovery <tool error>"
echo "  /tool-fix <tool error>"
