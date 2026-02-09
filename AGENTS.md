# Advent of Code 2025 - Python Project

## Requirements
- Python 3.14.2+

## Project Structure
```
src/
├── days/           # Daily challenge solutions
│   ├── day1/       # Day 1 folder
│   │   ├── day1.py # Day 1 solution (parts 1 & 2)
│   │   ├── demo.txt
│   │   ├── input.txt
│   │   └── debug1.txt
│   ├── day2/       # Day 2 folder
│   │   ├── day2.py
│   │   ├── demo.txt
│   │   ├── input.txt
│   │   └── debug2.txt
│   └── ...
└── commons/        # Shared utilities
```

## Conventions
- Daily files: `day{N}.py` in `src/days/day{N}/`
- Input files: `demo.txt`, `input.txt`, `debug{N}.txt` in `src/days/day{N}/`
- Each day folder contains both the solution file and all input files
- Each day file contains both part 1 and part 2 logic
- Shared logic goes in `src/commons/`

## Git Workflow
1. **Pre-feature setup**: Check for uncommitted files. If found, ask user to revert to HEAD
2. **Branch management**: Switch to main branch and pull latest changes
3. **Feature branch**: Create `feature/{feature-name}` branch
4. **Incremental commits**: Commit and push after each stage/step
5. **PR creation**: Create GitHub PR with description when feature is complete

**Available tools**: `git` and `gh` commands
