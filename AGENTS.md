# Advent of Code 2025 - Python Project

## Requirements
- Python 3.14.2+

## Python Modules
- **MANDATORY**: Python modules must be employed at all times
- **MANDATORY**: All importing between application files will be done using relative imports
- Examples:
  - Import from commons: `from ..commons.file_parser import parse_input_file`
  - Import from other days: `from ..day1.day1 import solve_part1`
  - Import within same day: `from .day1 import solve_part1`

## Project Structure
```
src/
├── days/           # Daily challenge solutions
│   ├── day1/       # Day 1 folder
│   │   ├── day1.py # Day 1 solution (parts 1 & 2)
│   │   ├── test_day1.py # Day 1 tests
│   │   ├── demo.txt
│   │   ├── input.txt
│   │   └── debug1.txt
│   ├── day2/       # Day 2 folder
│   │   ├── day2.py
│   │   ├── test_day2.py # Day 2 tests
│   │   ├── demo.txt
│   │   ├── input.txt
│   │   └── debug2.txt
│   └── ...
└── commons/        # Shared utilities
```

## Conventions
- Daily files: `day{N}.py` in `src/days/day{N}/`
- Test files: `test_day{N}.py` in `src/days/day{N}/`
- Input files: `demo.txt`, `input.txt`, `debug{N}.txt` in `src/days/day{N}/`
- Each day folder contains both the solution file, test file, and all input files
- Each day file contains both part 1 and part 2 logic
- Shared logic goes in `src/commons/`

## Testing Requirements
- **MANDATORY**: All days must have tests for part 1 and part 2 results
- Each test file (`test_day{N}.py`) must contain exactly two tests:
  - One test for part 1 result
  - One test for part 2 result
- No additional tests beyond these two requirements

## Git Workflow
- **MANDATORY**: Git workflow should be included in ANY PLAN MADE
- **MANDATORY**: Git workflow must be followed through during ANY IMPLEMENTATION

1. **Pre-feature setup**: Check for uncommitted files. If found, ask user to revert to HEAD
2. **Branch management**: Switch to main branch and pull latest changes
3. **Feature branch**: Create `feature/{feature-name}` branch
4. **Incremental commits**: Commit and push after each stage/step
5. **PR creation**: Create GitHub PR with description when feature is complete

**Available tools**: `git` and `gh` commands

## Git Exclusions
- **MANDATORY**: Cache folders and compiled files must never be committed
- **MANDATORY**: Ensure `.gitignore` excludes the following patterns:
  - `__pycache__/` - Python bytecode cache directories
  - `*.pyc` - Compiled Python files
  - `*.pyo` - Optimized Python files
  - `.pytest_cache/` - Pytest cache directories
  - `*.egg-info/` - Python package metadata
