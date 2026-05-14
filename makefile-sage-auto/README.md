# makefile-sage-auto

A companion plugin for [makefile-sage](../makefile-sage) that automatically detects projects with Makefiles and activates Makefile expertise at session start. Instead of requiring users to manually mention "Makefile" to trigger assistance, this plugin uses a `SessionStart` hook to scan for Makefiles when Claude starts up.

**Requires:** The `makefile-sage` plugin must also be installed.

## How It Works

The hook fires at session startup and on resume. It checks whether the current project directory contains a Makefile (`Makefile`, `makefile`, or `GNUmakefile`). If found, it runs `make help` to discover available targets and injects that information into Claude's context window. This gives Claude immediate awareness of the project's build system and available commands.

It respects the skill's safety guidelines: it will not interfere during deployments, production operations, or when other build tools are actively being used.

## Installation

Make sure you have already installed `makefile-sage` from this marketplace, then:

```
/plugin install makefile-sage-auto@makefile-sage
```

Reload:

```
/plugin reload
```

## How Hooks Work

This plugin uses a `SessionStart` hook to run a detection script when each new session starts or resumes. The hook is declared in `hooks/hooks.json`. The hook script lives at `hooks/hey-is-that-a-makefile.sh`. It reads the project directory from `CLAUDE_PROJECT_DIR`, checks for a Makefile, runs `make help` if available, and outputs the result as `hookSpecificOutput.additionalContext` JSON so Claude receives it as session context.

## License

BSD-0
