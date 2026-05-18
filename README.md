# Makefile Sage

A Claude Code plugin that helps create and improve Makefiles as executable documentation and discoverable interfaces to project workflows.

## Why It Exists

Most project documentation becomes stale over time. Makefiles, when done well, provide a living interface to your project that stays current because it IS the implementation. This plugin helps create Makefiles that are:

- **Discoverable**: `make help` shows what you can do
- **Safe**: Clear about what's risky vs. routine
- **Maintainable**: Readable code that orchestrates, doesn't implement
- **Practical**: Focused on real workflows, not theoretical perfection

## Installation

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

### Automatic Makefile Detection (Optional)

Install `makefile-sage-auto` alongside `makefile-sage` to have Claude automatically notice when you open a project that contains a Makefile and offer build system assistance:

```
/plugin install makefile-sage-auto@makefile-sage
```

## Local Makefile Usage

This repository includes a Makefile for installing the `makefile-sage` skill into a local Codex skills directory.

Show available Makefile targets:

```sh
make help
```

Print the source and install paths:

```sh
make paths
```

Install the skill to `~/.agents/skills/makefile-sage`:

```sh
make install
```

You can override the install root if needed:

```sh
make install INSTALL_ROOT=/path/to/skills
```

## Usage

The skill provides several focused capabilities:

```
/makefile-sage:makefile-sage analyze      # Analyze an existing Makefile
/makefile-sage:makefile-sage debug        # Debug Makefile issues
/makefile-sage:makefile-sage generate     # Generate a new Makefile from scratch
/makefile-sage:makefile-sage ensure_help  # Add or improve the help target
/makefile-sage:makefile-sage advise       # Get general advice about Makefile design
```

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

## License

BSD-0
