# Contributing Guidelines

Thank you for contributing to the FinTrend Analytics Platform. To ensure a smooth development process, please adhere to the following rules:

## Development Workflow
1. **Branching**: Branch off the latest `main` branch. Use descriptive names:
   * Feature: `feature/your-feature-name`
   * Bugfix: `bugfix/issue-description`
2. **Commit Messages**: Follow standard commit message naming rules (e.g. `feat: implement login panel`, `fix: correct card typography margin`).
3. **Coding Standards**:
   * Frontend styling relies on custom HSL design tokens inside `index.css`.
   * Enforce sharp corners (`border-radius: 0px`) on all new cards, buttons, or inputs.

## Pull Requests
* Ensure a successful production build runs without error (`npm run build`).
* Validate linter status with zero errors before submitting.
