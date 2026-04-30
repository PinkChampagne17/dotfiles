# Code Style

- Favor readability over raw performance.
- Use semantic variable names; longer and descriptive is better than short and cryptic.
- Prefer pipeline-style (declarative) code over imperative loops, such as `map`/`filter`/`reduce` instead of `for` loops in JavaScript, unless it hurts readability.
- Default to immutable bindings (`const` over `let`/`var`, `val` over `var`, and similar) unless mutability clearly improves readability.
- Avoid deeply nested inline expressions. Extract each step into its own named variable so the code reads like a pipeline.
- Name variables by what the result **is** (its type or role), not by the operation that produced it. For example:

```ts
// Bad - nested and hard to scan
const items = Array.from(container.querySelector(".list").querySelectorAll<HTMLElement>(".item"));

// Good - one operation per line, variables named by result type
const listElement = container.querySelector(".list");
const itemNodeList = listElement.querySelectorAll<HTMLElement>(".item");
const itemElements = Array.from(itemNodeList);
```
