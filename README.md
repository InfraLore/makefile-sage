# Makefile Sage

A Claude Code and Codex plugin that helps create and improve Makefiles as executable documentation and discoverable interfaces to project workflows.

## Why It Exists

Most project documentation becomes stale over time. Makefiles, when done well, provide a living interface to your project that stays current because it IS the implementation. This plugin helps create Makefiles that are:

- **Discoverable**: `make help` shows what you can do
- **Safe**: Clear about what's risky vs. routine
- **Maintainable**: Readable code that orchestrates, doesn't implement
- **Practical**: Focused on real workflows, not theoretical perfection

## Installation

### Claude Code

This repository is a Claude Code plugin marketplace. To install:

Add the marketplace:

```
/plugin marketplace add https://github.com/InfraLore/makefile-sage.git
```

Install the plugin:

```
/plugin install makefile-sage@makefile-sage
```

Restart Claude Code to activate.

### Codex

This repository is also a Codex plugin marketplace. To add it from GitHub:

```
codex plugin marketplace add https://github.com/InfraLore/makefile-sage.git
```

For local development from a checkout:

```
codex plugin marketplace add /path/to/makefile-sage
```

### Automatic Makefile Detection (Optional, Claude Code only)

Install `makefile-sage-auto` alongside `makefile-sage` to have Claude automatically notice when you open a project that contains a Makefile and offer build system assistance. This companion plugin uses a `SessionStart` hook and is currently Claude Code only.

```
/plugin install makefile-sage-auto@makefile-sage
```

## Usage

```
/makefile-sage analyze      # Analyze an existing Makefile
/makefile-sage debug        # Debug Makefile issues
/makefile-sage generate     # Generate a new Makefile from scratch
/makefile-sage ensure_help  # Add or improve the help target
/makefile-sage advise       # Get general advice about Makefile design
```

You can also invoke the skill without an argument and it will infer the right mode from context.

## Quick Examples

### Before: Undiscoverable
```makefile
run:
	docker-compose up -d

stop:
	docker-compose down
```

### After: Executable interface
```makefile
.PHONY: help dev stop clean

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

dev: ## Start development environment
	./scripts/dev.sh

stop: ## Stop all services
	./scripts/stop.sh

clean: ## Remove containers and volumes
	./scripts/clean.sh

.DEFAULT_GOAL := help
```

Now `make` (or `make help`) shows exactly what is available, and each target is self-documenting.

## Philosophy

We treat Makefiles as **clear, discoverable interfaces** to project workflows. The goal is maintainable, readable code that people can quickly understand and trust -- not the most technically sophisticated implementation.

See [makefile-sage/skills/makefile-sage/PRINCIPLES.md](makefile-sage/skills/makefile-sage/PRINCIPLES.md) for the complete design philosophy.

## Acknowledgements

Several structural and UX patterns in this plugin were inspired by [learning-opportunities](https://github.com/DrCatHicks/learning-opportunities) by [Dr. Cat Hicks](https://drcathicks.com) -- including escape hatch language, honest feedback guidelines, Codex plugin support, and the overall plugin structure. Highly recommended if you want to build genuine expertise while using AI coding tools.

## License

BSD-0
