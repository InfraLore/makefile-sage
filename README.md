# Makefile Sage

A Claude Code skill for creating and improving Makefiles that act as executable documentation and discoverable interfaces to project workflows.

## Why It Exists

Most project documentation becomes stale over time. Makefiles, when done well, provide a living interface to your project that stays current because it IS the implementation. This skill helps create Makefiles that are:

- **Discoverable**: `make help` shows what you can do
- **Safe**: Clear about what's risky vs. routine  
- **Maintainable**: Readable code that orchestrates, doesn't implement
- **Practical**: Focused on real workflows, not theoretical perfection

## How to Use

The skill provides several focused capabilities:

```bash
# Analyze an existing Makefile
makefile-sage analyze

# Debug Makefile issues  
makefile-sage debug

# Generate a new Makefile from scratch
makefile-sage generate

# Add or improve the help target
makefile-sage ensure_help

# Get general advice about Makefile design
makefile-sage advise
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

Now `make` (or `make help`) shows exactly what's available, and each target is self-documenting.

## Philosophy

We treat Makefiles as **clear, discoverable interfaces** to project workflows. The goal is maintainable, readable code that people can quickly understand and trust - not the most technically sophisticated implementation.

See [PRINCIPLES.md](PRINCIPLES.md) for the complete design philosophy.

## Licesne
BSD-0
