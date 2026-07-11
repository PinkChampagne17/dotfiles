# Code Style

- Favor readability over raw performance.
- Use semantic variable names; longer and descriptive is better than short and cryptic.
- Prefer pipeline-style (declarative) code over imperative loops, such as `map`/`filter`/`reduce` instead of `for` loops in JavaScript, unless it hurts readability.
- Default to immutable bindings (`const` over `let`/`var`, `val` over `var`, and similar) unless mutability clearly improves readability.
- Avoid deeply nested inline expressions. Extract each step into its own named variable so the code reads like a pipeline.
