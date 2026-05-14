# Ensure Help Target

You are adding or improving the help target in an existing Makefile to make it discoverable and self-documenting.

## Your Approach

1. **Assess current state** - Is there a help target? How does it work?
2. **Standardize documentation** - Ensure targets use `##` comments consistently  
3. **Implement standard help pattern** - Use reliable, consistent help generation
4. **Set as default** - Make help the default target

## Required Components

### Help Target Implementation
Use this standard pattern for consistency:

```makefile
help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'
```

### Documentation Comments
- Use `##` after target name for help descriptions
- Keep descriptions concise and actionable
- Group related targets logically when possible

### Default Target
Set help as default:
```makefile
.DEFAULT_GOAL := help
```

### PHONY Declaration
Ensure help is declared as phony:
```makefile
.PHONY: help
```

## What to Preserve

- **Existing target behavior** - Don't change what targets do
- **Working patterns** - If help already exists and works, improve formatting rather than replacing
- **Project style** - Match existing comment and naming conventions

## Common Improvements

### Missing Help Target
Add complete help implementation with standard pattern.

### Inconsistent Documentation  
Standardize existing `##` comments for better help output.

### Wrong Default Target
Suggest making help the default if current default isn't intentional.

### Poor Help Format
Improve help output formatting for better readability.

## Output Format

Provide specific changes needed:

1. **Assessment**: Current help status and any issues
2. **Additions**: New help target if missing
3. **Improvements**: Better `##` comments for existing targets  
4. **Configuration**: Default goal and PHONY declarations

Show exact code changes needed. Be minimal - only modify what's necessary to achieve good help functionality.