---
name: code-review-taste
description: Review code for architectural and design taste across types, static analyzability, immutability, purity, control flow, abstraction, and framework paradigms.
argument-hint: "[target] (optional, defaults to uncommitted changes)"
disable-model-invocation: true
---

# Review Code Taste

Evaluate target code for high-level design taste. Assume the code already compiles and passes typechecks, linters, and formatters. Focus on domain modeling, state and data flow, contract honesty, and module boundaries.

## 1. Gather Scope and Context

1. Resolve the review target:
   - If the user provides a target (file, directory, commit, or branch range), collect the changed or specified files from it.
   - If the user provides no target, collect uncommitted git changes (staged, unstaged, and untracked source files).
   - If no reviewable source files match or the target is ambiguous, use the `question` tool to clarify with the user.
2. Read every target file in full.
3. For modified or exported symbols in scope, read referenced type definitions and direct (1-hop) callers and callees to check real contracts and blast radius.
4. If the target includes test files, skip test-case coverage and evaluate the test code's own design. Calibrate to test ergonomics: type honesty, state isolation, and explicit local setup over premature helpers.
5. If the target spans multiple independent subsystems or large directories, consider delegating initial review per subsystem to parallel sub-agents. Assign all seven taste directions to each sub-agent, then merge cross-file intents in the main session.

## 2. Evaluate Taste Directions

Evaluate the target code across all seven taste directions below. Treat each direction as an open-ended `prefer` principle rather than a rigid checklist. Judge contracts, boundaries, state ownership, and multi-step flow rather than isolated statement mechanics. Surface every meaningful departure even when no immediate bug exists or competing constraints justify the design, and record both sides in the finding.

- **Type System Leverage**: Prefer types that encode domain invariants, narrow boundaries early (_parse, do not validate_), make illegal states unrepresentable, and preserve end-to-end inference.
- **Static-Analysis Friendliness**: Prefer lexical transparency and structures whose types, control flow, exhaustiveness, and dependency graphs remain tractable to compilers, static analyzers, and automated refactoring tools.
- **Immutability**: Prefer value semantics, readonly contracts, and immutable state transitions across boundaries and multi-step flows.
- **Referential Transparency & Purity**: Prefer deterministic input-to-output computation separated from side effects, ambient state, and I/O (_functional core, imperative shell_).
- **Honest Error & Control Flow**: Prefer signatures and linear control flow that expose failure channels, absence, and lifecycle states explicitly over sentinel values, swallowed errors, or deep nesting.
- **Orthogonality & Restraint in Abstraction**: Prefer orthogonal concerns, a single source of truth, and restraint over premature abstraction, pass-through indirection, or mode-flag coupling.
- **Library Paradigm Alignment & React Mindset for UI**:
  - Prefer designs that honor the core philosophy and mental model of each library or framework in use (for example, React's declarative rendering and state model).
  - For any **frontend UI component—regardless of library or framework**—evaluate whether React's portable ideas can improve the design. Prefer UI as a declarative projection of state, minimal canonical state with derived values, unidirectional data flow, and composition. Adapt the implementation mechanics to the host framework's own reactivity and execution model.

## 3. Report by Code Intent

1. Group findings under top-level headings named after the **code intent** (`## <Code Intent>`). Name each heading after a feature flow, domain capability, or module responsibility—never a file path or taste direction. Omit intents with no findings.
2. Merge cross-file symptoms that share one underlying design cause into a single finding.
3. Assign global sequential IDs (`T1`, `T2`, ...) and classify each finding by its cost and competing constraints:
   - `[Hazard]`: A taste flaw that hides failure, invites state drift, masks unvalidated contracts, or sets a trap for future edits.
   - `[Refinement]`: Working code where moving along a taste direction sharpens contracts, purity, or clarity for a clear net gain.
   - `[Trade-off]`: A design or contract departure backed by real competing constraints (such as throughput requirements, host API contracts, or proportional simplicity). Present both sides for user judgment.
4. In existing modules, report both proportional fixes inside the touched boundary and broader legacy taste debt across the module. Tag structural debt outside the immediate change scope with `(Module-level debt)`.
5. Format each finding with:
   - `### T<n> [Hazard | Refinement | Trade-off] — <Concise summary>` (insert `(Module-level debt)` right after the `[...]` tag when applicable)
   - **Locations**: Involved `path/to/file:line` references.
   - **Directions**: The relevant taste direction(s).
   - **Cost & Trade-offs**: Concrete maintenance, reasoning, or safety cost in this context weighed against any competing constraints (the basis for the severity tag).
   - **Preferred Direction**: The recommended structural or modeling evolution (with a brief sketch when helpful).
6. If the target code exhibits strong taste with no meaningful findings, state that clearly without padding.
7. Stop after you output the report. Wait for user confirmation before you edit any files.
