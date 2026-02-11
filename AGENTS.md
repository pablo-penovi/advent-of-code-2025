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

## Python Execution
- **MANDATORY**: All Python execution must be done using module syntax due to relative imports
- **MANDATORY**: Execute from project root directory (`/home/pablo/proyectos/python/aoc2025/`)
- **Correct execution examples**:
  - Run day 1: `python -m src.days.day1.day1 src/days/day1/input.txt`
  - Run day 2: `python -m src.days.day2.day2 src/days/day2/input.txt`
- **Testing execution**: `python -m pytest src/days/day1/test_day1.py -v`
- **Incorrect execution**: `python src/days/day1/day1.py` (will fail due to relative imports)

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
