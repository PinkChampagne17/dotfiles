# Testing

- When writing [Vitest](https://vitest.dev/) tests, prefer `onTestFinished` to clean up side effects. It keeps cleanup co-located with setup and improves readability.
