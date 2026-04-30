# Git

- Before performing destructive or modifying git operations such as `reset`, `rebase`, `rm`, `checkout --`, or force push, back up affected work first, preferably by creating a temporary branch. If a different backup method seems more appropriate, ask the user before proceeding.
- When force-pushing, always use `git push --force-with-lease` instead of `git push --force`. It avoids overwriting remote changes that have not been fetched yet.
- When a coding agent creates a git commit, include the coding agent itself as a co-author in the commit message.
