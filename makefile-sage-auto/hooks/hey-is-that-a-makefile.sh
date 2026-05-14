#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

# Check for any common Makefile variant
if [ -f "$PROJECT_DIR/Makefile" ] || [ -f "$PROJECT_DIR/makefile" ] || [ -f "$PROJECT_DIR/GNUmakefile" ]; then
    # Try to get make help output for context
    MAKE_HELP=""
    if command -v make >/dev/null 2>&1; then
        MAKE_HELP=$(cd "$PROJECT_DIR" && make help 2>/dev/null || echo "make help failed or not available")
    fi

    # Build the context message
    CONTEXT="Project interface summary:

- This repository exposes its primary workflows via a Makefile.
- Targets represent supported operations (build, test, deploy, etc.).

Available targets:
$MAKE_HELP

Behavior:
- Early in the conversation, mention the Makefile and offer help related to it if relevant."

    # Use jq to create proper JSON output
    jq -n \
    --arg context "$CONTEXT" \
    '{
        "hookSpecificOutput": {
            "hookEventName": "SessionStart",
            "additionalContext": $context
        }
    }'
fi

exit 0
