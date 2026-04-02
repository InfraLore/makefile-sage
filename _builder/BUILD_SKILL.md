## Generation Instructions

- Implement ALL files described in the structure
- Do not leave placeholders
- Ensure consistency across:
  - principles
  - prompts
  - examples
- Keep prompts concise and focused
- Ensure all generated Makefiles follow the principles

- Do not invent additional top-level files
- Do not omit any listed files

## Layout

This Claude Code skill will have the following layout.

makefile-sage/
├── README.md
├── PRINCIPLES.md
├── SKILL.md
├── examples/
│   ├── good/
│   │   ├── minimal.Makefile
│   │   ├── executable-readme.Makefile
│   ├── bad/
│   │   ├── complex-inline-logic.Makefile
│   │   ├── no-help-target.Makefile
├── prompts/
│   ├── advise.md
│   ├── analyze.md
│   ├── debug.md
│   ├── generate.md
│   ├── ensure_help.md
├── tests/
│   ├── fixtures/
│   │   ├── broken-makefile-1.mk
│   │   ├── missing-phony.mk
│   ├── cases.md
└── scripts/
    └── (optional helpers later)


## `README.md`

This is our **pitch + quickstart**.

Keep it tight:

- What the skill is
- Why it exists (executable README, discoverability)
- How to use it
- 1–2 examples

---

## `PRINCIPLES.md`

We already have this — it’s the **source of truth**.

This file:

- Should not change often
- Drives everything else
- Keeps behavior consistent

---

## `SKILL.md`

This is the **actual Claude Code skill definition**.

Think of it as:

> “How the assistant behaves in practice”

It should:

- Reference principles (implicitly, not verbatim)
- Define tools
- Define behavior patterns

---

## `prompts/`

This is where things get powerful.

Each file = **one capability, deeply tuned**

### `analyze.md`

- Explain targets
- Explain flow
- Emphasize `make help`

### `debug.md`

- Error classification
- Minimal fix first
- Optional improvement

### `generate.md`

- Create Makefiles
- Always include `help`
- Wrap existing commands only

### `ensure_help.md`

- Add or improve help target
- Normalize `##` comments

👉 This separation keeps prompts **focused and composable**

---

## `examples/`

This is _hugely valuable_ for grounding behavior.

### `good/`

- Clean, readable Makefiles
- Strong help usage
- Script-based orchestration

### `bad/`

- Long inline logic
- Missing `.PHONY`
- No discoverability

👉 These act like “training anchors” for the skill

---

## `tests/`

Not traditional tests — more like **evaluation cases**.

### `fixtures/`

Raw Makefiles with issues

### `cases.md`

Human-readable scenarios:

## Case: Missing help target  
  
Input:  
(makefile)  
  
Expected:  
- Suggest adding help target  
- Do not rewrite entire file

👉 This is how you keep the skill from drifting later

## More Cases
- “deploy target with kubectl”
- “clean target deleting volumes”
- “safe dev target”

---

## `scripts/` (optional for now)

You might not need this yet, but later you could:

- Auto-generate help targets
- Lint Makefiles
- Run test scenarios

---

# 🔑 Design principles for the repo itself

This part matters just as much as the code:

### 1. Keep prompts small and focused

Don’t create one giant mega-prompt.

---

### 2. Principles > prompts

If something feels unclear:

- Fix the principles
- Don’t hack around it in prompts

---

### 3. Examples are as important as code

They anchor behavior better than instructions.

---

### 4. Avoid premature tooling

You don’t need:

- CLI
- Build system
- Complex automation

Yet.
