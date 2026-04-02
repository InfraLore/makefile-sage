# Test Cases for Makefile Sage

## Case: Missing help target

**Input**: `examples/bad/no-help-target.Makefile`

**Expected**:
- Identify lack of discoverability
- Suggest adding help target with standard pattern
- Do not rewrite entire file
- Recommend making help the default target

**Key behaviors**:
- Should preserve all existing targets
- Should suggest `##` comments for documentation
- Should provide complete help implementation

---

## Case: Complex inline logic

**Input**: `examples/bad/complex-inline-logic.Makefile`

**Expected**:
- Identify overly complex inline shell scripts
- Recommend extracting logic to separate scripts
- Suggest simplified target structure
- Maintain original functionality intent

**Key behaviors**:
- Should not eliminate necessary logic
- Should show how to call scripts instead
- Should focus on readability improvements

---

## Case: Broken syntax

**Input**: `tests/fixtures/broken-makefile-1.mk`

**Expected**:
- Identify specific syntax errors (missing colon, mixed indentation)
- Provide minimal fixes for each issue
- Explain why each change is needed
- Verify fixes don't break functionality

**Key behaviors**:
- Should fix syntax without changing logic
- Should explain tab vs space indentation
- Should fix malformed target declarations

---

## Case: Missing PHONY declarations

**Input**: `tests/fixtures/missing-phony.mk`

**Expected**:
- Identify action targets that should be PHONY
- Recommend adding `.PHONY` declaration
- Explain why this matters (file conflicts)
- Suggest placement at top of file

**Key behaviors**:
- Should identify all action targets needing PHONY
- Should explain the purpose of PHONY declarations
- Should not suggest PHONY for file-generating targets

---

## Case: Deploy target safety

**Scenario**: Makefile with deploy targets that modify production infrastructure

**Expected**:
- Identify risky operations
- Suggest confirmation prompts
- Recommend clear naming (deploy-staging vs deploy-production)
- Suggest prerequisite validation

**Key behaviors**:
- Should distinguish between safe and risky targets
- Should recommend explicit user confirmation for destructive actions
- Should suggest environment validation

---

## Case: Generate minimal Makefile

**Input**: "Create a Makefile for a Python project"

**Expected**:
- Include help target as default
- Provide appropriate Python workflow targets
- Call scripts for multi-step workflows
- Include proper PHONY declarations

**Key behaviors**:
- Should ask about specific workflows needed
- Should not assume complex requirements
- Should provide working, complete example

---

## Case: Large legacy Makefile

**Scenario**: 200+ line Makefile with mixed patterns

**Expected**:
- Identify key improvement opportunities without complete rewrite
- Focus on discoverability improvements first
- Suggest incremental refactoring approach
- Preserve working functionality

**Key behaviors**:
- Should respect existing working patterns
- Should prioritize help/documentation improvements
- Should suggest organizing targets by prefix for 20+ targets

---

## Case: Safe development workflow

**Scenario**: Makefile with mix of dev and production targets

**Expected**:
- Clearly separate safe development tasks from risky operations
- Make common dev tasks easy and safe
- Require deliberate action for production changes
- Group related targets logically

**Key behaviors**:
- Should make dev workflow frictionless
- Should add safety checks to production targets
- Should use clear, predictable naming

---

## Case: Analysis of well-structured Makefile

**Input**: `examples/good/executable-readme.Makefile`

**Expected**:
- Recognize good patterns and explain why they work
- Identify the workflow and target relationships
- Note script-based orchestration pattern
- Highlight discoverability features

**Key behaviors**:
- Should acknowledge good design when present
- Should explain the executable documentation pattern
- Should note safety and usability features