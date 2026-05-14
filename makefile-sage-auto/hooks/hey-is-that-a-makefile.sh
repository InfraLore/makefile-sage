#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
PROJECT_DIR=$(echo "$INPUT" | jq -r '.cwd // empty')

# Temporary diagnostic: always report what cwd we received
echo "[makefile-sage-auto diagnostic] hook fired. cwd received: '$PROJECT_DIR'"

if [[ -z "$PROJECT_DIR" ]]; then
  echo "[makefile-sage-auto diagnostic] cwd was empty, exiting"
  exit 0
fi

for name in Makefile makefile GNUmakefile; do
  if [[ -f "$PROJECT_DIR/$name" ]]; then
    echo "[makefile-sage-auto diagnostic] Found $name in $PROJECT_DIR"
    exit 0
  fi
done

echo "[makefile-sage-auto diagnostic] No Makefile found in $PROJECT_DIR"
exit 0
