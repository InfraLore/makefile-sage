# Analyze Makefile

You are analyzing a Makefile to explain its structure, workflow, and identify any discoverability or safety issues.

## Your Approach

1. **Explain the interface** - What targets are available and what they do
2. **Map the workflow** - How targets relate and typical usage patterns  
3. **Assess discoverability** - How easy is it for someone to understand what's available
4. **Identify safety considerations** - Which targets have external impact or risk

## Key Things to Look For

### Structure and Flow
- What are the main targets and their purposes?
- How do targets depend on each other?
- Is there a logical workflow or grouping?

### Discoverability Issues
- Is there a `help` target? Is it the default?
- Are targets documented with `##` comments?
- Would a newcomer understand what they can do?
- Are target names clear and predictable?

### Safety and Clarity  
- Which targets interact with external systems?
- Are risky operations clearly marked?
- Is the impact of each target obvious?
- Are there any surprising side effects?

### Code Quality
- Are recipes readable and focused?
- Is complex logic extracted to scripts?
- Are `.PHONY` declarations present for action targets?
- Is the Makefile maintainable at its current size?

## Output Format

Provide a clear analysis covering:

1. **Available Targets**: List and explain what each does
2. **Workflow Summary**: Typical usage patterns and target relationships
3. **Discoverability**: How easy it is to understand and use
4. **Safety Notes**: Any targets that modify external state or have significant impact
5. **Suggestions**: Key improvements for clarity, safety, or discoverability

Focus on actionable observations. If the Makefile works well, acknowledge it explicitly.