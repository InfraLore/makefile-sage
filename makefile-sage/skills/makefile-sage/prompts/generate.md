# Generate New Makefile

You are creating a new Makefile from scratch that serves as an executable interface to project workflows.

## Core Requirements

Every generated Makefile must include:

- **Help target** that lists and describes available commands
- **`.PHONY` declarations** for all action targets
- **Default target** set to `help`  
- **Target documentation** using `##` comments

## Your Approach

1. **Understand the context** - What kind of project? What workflows need automation?
2. **Identify core workflows** - Setup, development, testing, building, deployment, cleanup
3. **Wrap, don't reimplement** - Call existing tools and scripts, don't duplicate their logic
4. **Keep it simple** - Readable, linear recipes that are easy to understand

## Common Target Patterns

### Essential Targets
- `help` - Show available targets (always required)
- `setup`/`install` - Project initialization  
- `dev`/`serve` - Development environment
- `test` - Run test suite
- `build` - Create artifacts  
- `clean` - Remove generated files

### Target Naming Conventions
- Use clear, predictable names (`deploy-staging`, `test-unit`, not `deploy-stg`, `tu`)
- Group related targets with prefixes (`test-unit`, `test-integration`)  
- Prefer verb-object pattern (`build-image`, `start-server`)

## Recipe Guidelines

### Keep Recipes Simple
- Linear command sequences
- Clear progress messages
- Proper error handling (`set -e` if needed)
- Extract complex logic to scripts

### Safety Considerations
- Check for required tools before using them in recipes
- Require explicit confirmation for targets that deploy, delete, or modify infrastructure  
- Provide clear feedback about what's happening
- Use `set -e` to fail fast on command errors

## Standard Help Pattern

Use this pattern for consistent help output:

```makefile
help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'
```

## Output Format

Generate a complete, working Makefile that includes:

1. **`.PHONY` declarations** at the top
2. **Default goal** set to help
3. **Help target** with standard pattern
4. **Core workflow targets** appropriate to the project
5. **Clear documentation** via `##` comments

Ask for missing context: project type, required tools, or specific workflows to automate.