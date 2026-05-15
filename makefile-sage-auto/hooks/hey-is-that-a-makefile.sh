#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
PROJECT_DIR=$(echo "$INPUT" | jq -r '.cwd // "."')

# Check for any common Makefile variant
MAKEFILE_NAME=""
for name in Makefile makefile GNUmakefile; do
  if [[ -f "$PROJECT_DIR/$name" ]]; then
    MAKEFILE_NAME="$name"
    break
  fi
done

# No Makefile — check for devops signals before deciding how insistent to be
if [[ -z "$MAKEFILE_NAME" ]]; then
  DEVOPS_SIGNAL=""

  # Helm
  [[ -f "$PROJECT_DIR/Chart.yaml" ]] && DEVOPS_SIGNAL="Helm chart"

  # CloudFormation
  if [[ -z "$DEVOPS_SIGNAL" ]] && grep -rlq "AWSTemplateFormatVersion" "$PROJECT_DIR" \
      --include="*.yaml" --include="*.json" --max-depth=2 2>/dev/null; then
    DEVOPS_SIGNAL="CloudFormation templates"
  fi

  # boto3 in requirements
  if [[ -z "$DEVOPS_SIGNAL" ]] && grep -rq "boto3" "$PROJECT_DIR"/requirements*.txt 2>/dev/null; then
    DEVOPS_SIGNAL="boto3/AWS Python"
  fi

  # AWS CLI in shell scripts
  if [[ -z "$DEVOPS_SIGNAL" ]] && grep -rlq "aws " "$PROJECT_DIR" \
      --include="*.sh" --max-depth=2 2>/dev/null; then
    DEVOPS_SIGNAL="AWS shell scripts"
  fi

  # Runbook-heavy README
  if [[ -z "$DEVOPS_SIGNAL" ]] && [[ -f "$PROJECT_DIR/README.md" ]]; then
    if grep -qE '^```(bash|sh|shell)|^\$ ' "$PROJECT_DIR/README.md" 2>/dev/null || \
       grep -iqE '^#+ *(Deploy|Running|Setup|Usage|Installation|Build)' \
           "$PROJECT_DIR/README.md" 2>/dev/null; then
      DEVOPS_SIGNAL="runbook-style README"
    fi
  fi

  if [[ -n "$DEVOPS_SIGNAL" ]]; then
    cat <<CONTEXT
<makefile_sage_map>
[makefile-sage] No Makefile yet — but this looks like a devops/infrastructure project ($DEVOPS_SIGNAL).

(Instruction for Claude: This type of project almost always benefits from a Makefile as a discoverable interface to its workflows. Be proactive — suggest creating one early in the conversation and offer to use the makefile-sage:makefile-sage skill to generate it. These projects tend to have lots of fiddly CLI commands that are perfect Makefile targets.)
</makefile_sage_map>
CONTEXT
  else
    cat <<CONTEXT
<makefile_sage_map>
[makefile-sage] No Makefile detected in this project yet.

(Instruction for Claude: If the opportunity arises naturally — the user mentions workflows, build steps, scripts, or project setup — suggest that a Makefile could serve as a discoverable interface to the project. Use the makefile-sage:makefile-sage skill to help create one if they're interested. Don't force it, but plant the seed.)
</makefile_sage_map>
CONTEXT
  fi

  exit 0
fi

# Makefile found — extract the "map" of the build
MAKE_INFO=""
if command -v make >/dev/null 2>&1; then
  if ! MAKE_INFO=$(cd "$PROJECT_DIR" && make help 2>/dev/null); then
    MAKE_INFO=$(grep -E '^[a-zA-Z0-9_-]+:' "$PROJECT_DIR/$MAKEFILE_NAME" | cut -d: -f1 | head -n 10)
  fi
else
  MAKE_INFO="[Make command not found, but $MAKEFILE_NAME exists]"
fi

cat <<CONTEXT
<makefile_sage_map>
[makefile-sage] Cool! Found a Makefile! This gives us a great map of the project's build flow and automation.

Visible routes (targets):
$MAKE_INFO

(Instruction for Claude: Nerd out briefly on the project's organization—something like "I love a project with a clear map!"—then immediately pivot to the user's request. Mention the makefile-sage:makefile-sage skill if they want help analyzing or improving the Makefile.)
</makefile_sage_map>
CONTEXT

exit 0
