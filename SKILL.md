# Skill: makefile-sage

## Purpose

Helps create and improve Makefiles that serve as executable documentation and discoverable interfaces to project workflows. Focuses on maintainability, safety, and usability over technical sophistication.

## When to Apply This Skill

Use makefile-sage expertise when:
- User asks about Makefiles directly
- User mentions project workflow discoverability  
- User shows a Makefile and asks for help

Be careful when:
- User is in the middle of deployments or builds
- User is working with other build systems

## Capabilities

### analyze
Examines existing Makefiles to explain structure, identify patterns, and highlight discoverability or safety issues.

### debug  
Diagnoses Makefile errors and provides minimal fixes, focusing on root causes rather than workarounds.

### generate
Creates new Makefiles from scratch, always including help targets and following orchestration-over-implementation patterns.

### ensure_help
Adds or improves help targets in existing Makefiles, standardizing on `##` comment patterns for auto-generated documentation.

### advise
Provides general guidance on Makefile design patterns, safety considerations, and incremental improvement strategies.

## Execution Procedures

## Procedures

### analyze

1. Detect presence of a Makefile
2. If a Makefile exists:
   - Attempt to run `make help` to discover available targets
   - If `make help` succeeds:
     - Treat its output as the primary interface for available commands
   - If `make help` is missing or fails:
     - Inspect the Makefile directly
     - Suggest adding or improving a help target
3. Explain targets, structure, and workflows
4. Highlight issues with discoverability, safety, or clarity

### debug

1. Identify the error or failure
2. If a Makefile is involved:
   - Attempt to run `make help` to understand available targets
3. Locate the failing target or command
4. Provide a minimal fix addressing the root cause
5. Optionally suggest improvements aligned with principles

## Behavior Patterns

### Safety First
- Clearly identify targets that interact with external systems (cloud, containers, infrastructure)
- Distinguish between safe development tasks and risky operations  
- Require explicit confirmations for targets that deploy, delete resources, or modify infrastructure
- Validate tool dependencies for targets that call external commands

### Discoverability Focus
- Always ensure `make help` exists and works
- Make help the default target when no arguments given
- Use `##` comments consistently for target documentation  
- Favor self-describing target names over clever abbreviations
- Prefer using `make help` as the primary way to discover available commands when working with a Makefile

### Incremental Improvement
- Prefer small, localized improvements over complete rewrites
- Preserve working behavior and original intent
- Do not restructure or reorganize without explicit user request
- Focus on clarity first, optimization last

### Orchestration Over Implementation  
- Keep recipes short, linear, and readable
- Recommend extracting complex logic to scripts
- Avoid clever Make features that reduce readability
- Signal when inline logic is growing too complex

### Practical Output
- Show improved code rather than abstract advice
- Provide actionable, specific suggestions
- Avoid over-explaining obvious concepts

## Tools and Prompts

The skill uses focused prompts for each capability:

- `prompts/analyze.md` - Explains targets, flow, and structure  
- `prompts/debug.md` - Error diagnosis and minimal fixes
- `prompts/generate.md` - Creates new Makefiles with best practices
- `prompts/ensure_help.md` - Adds/improves help targets specifically
- `prompts/advise.md` - General design guidance

## Inputs

- Existing Makefile content (for analyze, debug, ensure_help)
- Project context and requirements (for generate)  
- Specific error messages or issues (for debug)

## Outputs

- Analyzed explanations with highlighted issues
- Minimal fix suggestions with rationale
- Complete, working Makefile examples
- Incremental improvements to existing files
- Design guidance tailored to project context

## Rules

- Always include `.PHONY` declarations for action targets
- Default target should be `help` unless explicitly requested otherwise  
- Preserve existing working behavior unless improvement is requested
- Extract complex logic to scripts rather than embedding in recipes
- Use consistent, predictable target naming patterns
- Provide clear progress messages and error handling
- Only execute `make help` automatically; do not run other targets unless explicitly requested

## Failure Modes

- Missing context about project → ask for clarification about tools, workflows, or constraints
- Unclear intent → choose safest, most maintainable interpretation  
- Complex existing Makefile → focus on minimal improvements rather than rewrites
- Legacy patterns → respect existing style while suggesting modern alternatives
