# Changelog

All notable changes to this project will be documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.1.0] - 2026-05-18

### Added
- Codex plugin support via `.codex-plugin/plugin.json`
- `## When Not to Apply` section in SKILL.md with explicit guard conditions
- `### Escape Hatches` behavior pattern in SKILL.md -- check-in language for long analysis and debug sessions
- `$ARGUMENTS` routing in SKILL.md -- explicit mode selection when invoked as `/makefile-sage analyze`, `/makefile-sage debug`, etc.
- Honest Assessment section in `analyze.md` -- guidance against over-praising or softening feedback
- Honest Diagnosis section in `debug.md` -- guidance against validating broken patterns or crediting partial understanding
- Honest Guidance section in `advise.md` -- guidance against validating design choices just because the user is already using them
- Check-in prompts at the end of each prompt file's output format
- Acknowledgements section in README crediting Dr. Cat Hicks / learning-opportunities

### Changed
- README Installation section split into `### Claude Code` and `### Codex` subsections
- README usage examples updated to short slash command style (`/makefile-sage analyze` instead of `/makefile-sage:makefile-sage analyze`)
- `makefile-sage-auto` noted as Claude Code only in README
- Vague "Be careful when" block replaced with dedicated `## When Not to Apply` section

## [1.0.0] - 2026-05-15

### Added
- `makefile-sage-auto` companion plugin with `SessionStart` hook for automatic Makefile detection
- Hook detects `Makefile`, `makefile`, or `GNUmakefile` at session start and injects `make help` output as context
- Target grep fallback in hook when `make help` is unavailable
- No-Makefile path: devops signal detection and runbook README heuristic
- `argument-hint` frontmatter in SKILL.md
- Gentle one-shot suggestion behavior when no Makefile is present

### Changed
- Restructured repository as a plugin marketplace containing both `makefile-sage` and `makefile-sage-auto`
- Hook simplified to read cwd from JSON input and use plain stdout output

### Removed
- Resume hook (session start only)
- Stale Zed rules and builder artifacts

## [0.1.0] - 2026-04-02

### Added
- First draft of the `makefile-sage` skill with `analyze`, `debug`, `generate`, `ensure_help`, and `advise` capabilities
- SKILL.md, PRINCIPLES.md, NOTES.md, and per-capability prompt files
- Good and bad Makefile examples
- Test cases and fixtures
- Guidance on when to apply the skill
- Notes on Makefile environment variables and DirEnv compatibility
