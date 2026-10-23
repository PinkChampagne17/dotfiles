---
name: p-plan-mode
description: Personal conventions for Plan Mode and implementation plans. Load and follow this skill automatically when you enter Plan Mode or draft, revise, or present an implementation plan.
---

# Plan Mode Conventions

Follow these conventions when you operate in Plan Mode or present an implementation plan.

## Code Outline

- When a plan changes code structure, include a VS Code-style **Code Outline**.
- Structural changes include new files or changes to functions, classes, types, interfaces, component props or state, and module variables.
- Do not include an outline for minor config edits, text changes, or small local fixes.
- **Scope per file**:
  - **New files**: Show all symbols in the file.
  - **Existing files**: Show only added (`[+]`), modified (`[~]`), or removed (`[-]`) symbols, their parent containers, and related context. Omit unchanged symbols.
- **Granularity**:
  - Include top-level declarations (types, interfaces, classes, functions, module variables), class members, type fields, and component props, state, and hooks.
  - Inline short type fields (`{ ... }`), and expand complex types as child nodes.
  - Omit local variables inside function bodies.
- **Signatures and annotations**:
  - Write explicit type signatures for all variables, properties, parameters, and return values.
  - For modified (`[~]`) symbols, write the new signature and add a short `//` comment that explains the change.
- **Format**:
  ```text
  src/user/service.ts
  ├── [+] interface UserFilter { role?: Role; active: boolean }
  ├── [~] class UserService
  │   ├── [+] private readonly cache: Map<string, User>
  │   └── [~] async findUsers(filter: UserFilter, limit?: number): Promise<User[]> // add limit param and cache lookup
  └── [+] export const DEFAULT_LIMIT: number = 50
  ```
