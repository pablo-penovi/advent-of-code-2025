# Git Skill

This skill defines the standard Git workflow for agents working on this project. Following these rules ensures proper version control, collaboration, and code review processes.

## Rules

### 1. Branch Management
- **Always start new branch when implementing new feature**
- Branch naming convention: `feature/{succinct-name-according-to-feature}`
  - Use descriptive, concise names
  - Use kebab-case (lowercase with hyphens)
  - Examples:
    - `feature/day-selector-ui`
    - `feature/memory-leak-fix`
    - `feature/vaxis-integration`

### 2. Commit and Push Requirements
- **Commit and push after finishing each task**
- This ensures:
  - Progress tracking and backup
  - Collaboration visibility
  - Clear history of changes
- Use descriptive commit messages that explain what was accomplished

### 3. Pull Request Creation
- **Create a PR after finishing the task**
- PR title: Same as the branch name
- PR description: Summary explaining all changes that were implemented
- Include:
  - Brief overview of the feature/fix
  - Key changes made
  - Any breaking changes or considerations
  - Testing performed

## Workflow Steps

### For New Features
1. **Create feature branch**
   ```bash
   git checkout -b feature/{feature-name}
   ```

2. **Implement changes**
   - Write code
   - Test thoroughly
   - Follow project conventions

3. **Commit and push**
   ```bash
   git add .
   git commit -m "Descriptive commit message"
   git push origin feature/{feature-name}
   ```

4. **Create Pull Request**
   ```bash
   gh pr create --title "feature/{feature-name}" --body "Comprehensive description of changes"
   ```
   - Use branch name as PR title
   - Write comprehensive description including summary, key changes, and testing performed
   - Request review if needed

### For Bug Fixes
1. **Create feature branch** (same naming convention)
2. **Fix the issue**
3. **Test the fix**
4. **Commit and push**
5. **Create PR** with explanation of the bug and fix:
   ```bash
   gh pr create --title "fix/{bug-name}" --body "Explanation of bug and fix"
   ```

## Commit Message Guidelines

### Format
- Use clear, descriptive messages
- Focus on what was accomplished, not how
- Keep messages concise but informative

### Examples
```
Add day selection functionality to TUI interface
Fix memory leak in DaySelector deinit
Implement keyboard navigation for list view
Update Vaxis dependency to latest version
```

## Branch Naming Examples

### Feature Branches
- `feature/day-selector-ui`
- `theme/dark-mode-support`
- `feature/input-validation`
- `feature/performance-optimization`

### Bug Fix Branches
- `fix/memory-leak-widget`
- `fix/keyboard-navigation-bug`
- `fix/display-glitch-resize`

## Quality Assurance

### Before Committing
- Run tests: `zig build test`
- Verify functionality: `zig build run`
- Check code style and conventions
- Ensure no sensitive data is committed

### Before Creating PR
- Ensure all commits are pushed
- Verify the branch is up-to-date with main
- Test the feature thoroughly
- Review your own changes first

## Enforcement

These rules are mandatory for all agents working on the project. Following them ensures:

- Consistent version control practices
- Clear project history
- Effective collaboration
- Proper code review process
- Safe and incremental development

## Notes

- Always pull latest changes from main before creating a new feature branch
- Keep branches focused on single features or fixes
- Avoid force pushing unless absolutely necessary
- Delete merged branches to keep repository clean
