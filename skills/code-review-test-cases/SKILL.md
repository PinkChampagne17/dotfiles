---
name: code-review-test-cases
description: Review test cases against their implementation to remove redundant tests, merge overlapping tests, and add missing high-value tests.
argument-hint: "[target] (optional, defaults to uncommitted changes)"
disable-model-invocation: true
---

# Review Test Cases

Review test cases against their implementation in three areas: **Remove** unnecessary cases, **Merge** overlapping cases, and **Add** missing cases.

## 1. Find Target Files

1. Get the input scope:
   - If the user provides a target (file, directory, commit, or branch range), get the changed files from that target.
   - If the user provides no target, get the uncommitted git changes (staged, unstaged, and untracked files).
2. Map test files and implementation files in both directions:
   - For each changed **test file**, find and read its **implementation file**.
   - For each changed **implementation file**, find and read its existing **test files**, and include them in the review.
3. If no test files match, use the `question` tool to ask the user which test files to review.
4. Read both the test files and the implementation files in full before you review the test cases.

## 2. Review Test Cases

Check each test file for test-case selection and coverage against the implementation. Do not report code style issues. Do not suggest low-value tests to fill a category. If a category has no findings, write `None`.

### Remove (Unnecessary Cases)

Mark a test case for removal when it:

- **Tests mocks or tautologies**: Asserts only what a mock returns without running real implementation logic.
- **Tests language, framework, or library behavior**: Checks static types, simple getters or setters, or third-party code instead of project logic.
- **Duplicates a broader test**: Covers a strict subset of the code path and assertions of another test in the same equivalence class.
- **Couples to private details**: Asserts internal call order or private state when other tests already check observable results.

### Merge (Overlapping Cases)

Mark test cases for merging when they:

- **Repeat the same equivalence class**: Pass different inputs through the exact same implementation branch. Keep one representative case, or combine them into a parameterized test (such as `test.each`).
- **Split one behavior across single-assertion tests**: Repeat the same setup and action only to assert different fields of the same result. Merge them into one test case.

### Add (Missing High-Value Cases)

Mark missing test cases when the implementation has:

- **Uncovered branches**: Conditional branches, guard clauses, early returns, or fallbacks with no test.
- **Boundary and invalid inputs**: Threshold values, empty collections, zero, `null`, `undefined`, or invalid formats that the implementation handles.
- **Error paths and cleanup**: Thrown errors, rejected promises, state rollback, or resource cleanup after a failure.

## 3. Report and Confirm

1. Group the report by **test file**. Under each file, use the headings `### Remove`, `### Merge`, and `### Add` (omit empty headings or write `None`).
2. Give each finding a short ID (`R1`, `R2`, `M1`, `M2`, `A1`, `A2`) and include:
   - **Test case**: The test name and line numbers (or target `describe` block for additions).
   - **Implementation**: The function, branch, or line numbers in the implementation file.
   - **Reason and action**: A one-sentence reason and the specific change to make.
3. If there are no findings across all files, stop and report that the test suite is clean.
4. If there are findings, use the `question` tool with `multiple: true` so the user can select which findings to apply:
   - List each finding ID as an option (`label`: `<ID>: <short title>`, `description`: `<test file> — <action summary>`).

## 4. Apply and Verify

When the user selects findings to apply:

1. Load and follow the `pcp-code-conventions` skill before you edit test code.
2. Apply the selected removals, merges, and additions to the test files.
3. Run the project test runner on the modified test files and make sure all tests pass.
