#!/usr/bin/env bash
set -euo pipefail

# makefile-sage-auto: SessionStart hook (matches: startup|resume)
#
# Reads cwd from the hook's JSON input, checks for a Makefile,
# and prints context to stdout (which SessionStart passes directly to Claude).

INPUT=$(cat)

# Read cwd from the hook JSON input - this is always reliable for SessionStart
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

# Plain stdout reaches Claude directly on SessionStart - no JSON wrapper needed
cat <<CONTEXT
[makefile-sage-auto] A Makefile ($MAKEFILE_NAME) was detected in this project.

Project interface summary:
- This repository exposes its primary workflows via a Makefile.
- Targets represent supported operations (build, test, deploy, etc.).

Available targets:
$MAKE_HELP

Invoke the makefile-sage:makefile-sage skill and mention the Makefile early in the conversation.
CONTEXT

exit 0
