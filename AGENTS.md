# Advent of Code 2025 - Python Project

## Requirements
- Python 3.14.2+

## Project Structure
```
src/
├── days/           # Daily challenge solutions
│   ├── day1.py     # Day 1 solution (parts 1 & 2)
│   ├── day1.txt    # Day 1 inputs
│   └── ...
└── commons/        # Shared utilities
```

## Conventions
- Daily files: `day{N}.py` in `src/days/`
- Input files: `demo.txt`, `input.txt`, `debug{N}.txt`
- Each day file contains both part 1 and part 2 logic
- Shared logic goes in `src/commons/`

## Git Workflow
1. **Pre-feature setup**: Check for uncommitted files. If found, ask user to revert to HEAD
2. **Branch management**: Switch to main branch and pull latest changes
3. **Feature branch**: Create `feature/{feature-name}` branch
4. **Incremental commits**: Commit and push after each stage/step
5. **PR creation**: Create GitHub PR with description when feature is complete

**Available tools**: `git` and `gh` commands