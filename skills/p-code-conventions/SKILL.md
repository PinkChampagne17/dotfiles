---
name: p-code-conventions
description: Personal code conventions for implementation and testing. Load and follow this skill automatically when you write, edit, refactor, or review code and tests. On direct invocation, refactor the target code to match these conventions.
argument-hint: "[target] (optional, defaults to uncommitted changes)"
---

# Code Conventions

Follow these conventions when you write, edit, refactor, or review code and tests.

## General

- Prefer readability over raw performance.
- Prefer functional array/iterator methods or pipeline functions(flatMap, filter, map) over for loops; use type guards on filter to maintain type inference downstream
- Use immutable bindings (`const`, `val`) by default.
- Split nested expressions into named variables to keep logic linear and clear.
- In JavaScript and TypeScript, write non-inlined arrow functions with a block body (`{}`). Add an explicit `return` statement when needed.
- Validate unknown values once at the boundary that owns them. Pass typed values inward instead of repeating `typeof value === "object"` and property-existence checks. Do not defensively revalidate values already guaranteed by a schema, constructor, or internal type.

## Testing

- Test behavior through the public API and assert observable outputs or side effects. Do not test private helpers, internal state, or implementation details directly.
- Avoid test lifecycle hooks such as `beforeEach`, `afterEach`, `beforeAll`, and `afterAll`.
- Wrap reusable arrange code in helper functions. Call these helpers directly in the test cases that need them.
- Clean up resources and side effects inside the test scope. For example, in [Vitest](https://vitest.dev/), call `onTestFinished` right after you create a resource or cause a side effect.

## Direct Invocation

On direct invocation, refactor the target code to match the conventions above. Do not change runtime behavior.

- **Default target**: Uncommitted changes.
- **Target examples**: `unstaged changes`, `staged changes`, `HEAD`, `<commit-hash>`, `<branch> against <branch>`, `<file-path>`.
