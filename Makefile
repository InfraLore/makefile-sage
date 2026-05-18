SHELL := /bin/sh
.DEFAULT_GOAL := help

SKILL_NAME := makefile-sage
SOURCE_DIR := makefile-sage/skills/$(SKILL_NAME)
INSTALL_ROOT ?= $(HOME)/.agents/skills
INSTALL_DIR := $(INSTALL_ROOT)/$(SKILL_NAME)

.PHONY: help install paths verify-source

help: ## Show available targets.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make <target>\n\nTargets:\n"} /^[a-zA-Z0-9_.-]+:.*##/ {printf "  %-16s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: verify-source ## Install makefile-sage into ~/.agents/skills.
	@printf 'Installing %s to %s\n' "$(SKILL_NAME)" "$(INSTALL_DIR)"
	@mkdir -p "$(INSTALL_DIR)"
	@cp -R "$(SOURCE_DIR)/." "$(INSTALL_DIR)/"
	@printf 'Installed %s\n' "$(SKILL_NAME)"

paths: ## Print source and install paths.
	@printf 'SOURCE_DIR=%s\n' "$(SOURCE_DIR)"
	@printf 'INSTALL_DIR=%s\n' "$(INSTALL_DIR)"

verify-source:
	@test -f "$(SOURCE_DIR)/SKILL.md" || { \
		printf 'Missing skill source: %s/SKILL.md\n' "$(SOURCE_DIR)" >&2; \
		exit 1; \
	}
