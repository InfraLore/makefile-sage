#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
PROJECT_DIR=$(echo "$INPUT" | jq -r '.cwd // empty')

if [[ -z "$PROJECT_DIR" ]]; then
  exit 0
fi

# Check for any common Makefile variant
MAKEFILE_NAME=""
for name in Makefile makefile GNUmakefile; do
  if [[ -f "$PROJECT_DIR/$name" ]]; then
    MAKEFILE_NAME="$name"
    break
  fi
done

if [[ -z "$MAKEFILE_NAME" ]]; then
  exit 0
fi

# Try to get make help output for context
MAKE_HELP=""
if command -v make >/dev/null 2>&1; then
  MAKE_HELP=$(cd "$PROJECT_DIR" && make help 2>/dev/null || echo "make help not available")
fi

cat <<CONTEXT
[makefile-sage-auto] This project contains a Makefile. Before responding to the user's first message, briefly acknowledge the Makefile and offer to help with it. Use the makefile-sage:makefile-sage skill to do so.

Available targets:
$MAKE_HELP
CONTEXT

exit 0
