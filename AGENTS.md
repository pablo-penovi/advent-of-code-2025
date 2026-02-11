# Advent of Code 2025 - Python Project

## Requirements
- Python 3.14.2+

## Python Modules
- **MANDATORY**: Python modules must be employed at all times

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

## Coding Practices
- **MANDATORY**: All coding practices must be followed consistently across the project

### Import Conventions
- **MANDATORY**: All importing between application files uses absolute imports from project root
- Examples:
  - Import from commons: `from src.commons.file_parser import parse_input_file`
  - Import from other days: `from src.days.day1.day1 import solve_part1`
  - Import within same day: `from src.days.day1.day1 import solve_part1`
- Local imports in main functions: Import standard library modules locally within main() when only used there
- Import grouping: Standard library imports grouped separately from project imports

### File and Naming Conventions
- Daily files: `day{N}.py` in `src/days/day{N}/`
- Test files: `test_day{N}.py` in `src/days/day{N}/`
- Input files: `demo.txt`, `input.txt`, `debug{N}.txt` in `src/days/day{N}/`
- Each day folder contains both the solution file, test file, and all input files
- Each day file contains both part 1 and part 2 logic
- Shared logic goes in `src/commons/`
- Function naming patterns:
  - Parser functions: `parse_*` (e.g., `parse_rotation`, `parse_ranges`)
  - Validation functions: `is_*` (e.g., `is_invalid_id`)
  - Finder functions: `find_*` (e.g., `find_max_joltage`)
  - Solution functions: `solve_part1`, `solve_part2`

### Function Documentation Standards
- **MANDATORY**: All functions must have triple-quote docstrings
- Docstring format includes Args, Returns, Raises sections where applicable
- Parameter documentation matches type hints with clear descriptions
- Return value documentation includes expected types and behavior
- Example:
```python
def parse_rotation(line: str) -> tuple[str, int]:
    """
    Parse a rotation instruction like 'L68' or 'R48'.
    
    Args:
        line: String containing rotation instruction
        
    Returns:
        tuple: (direction, distance) where direction is 'L' or 'R'
        
    Raises:
        ValueError: If line format is invalid or empty
    """
```

### Type Hints and Validation
- **MANDATORY**: All functions must use proper type hints in signatures
- Input validation with descriptive ValueError exceptions
- Guard clauses for edge cases (empty inputs, invalid formats)
- Early returns for invalid conditions
- Variable naming includes type suffixes where helpful (e.g., `num_str` for string numbers)

### Code Organization Patterns
- Helper functions with single responsibility principle
- Main function structure:
  1. Argument validation with usage message
  2. File parsing using commons module
  3. Part 1 and Part 2 execution
  4. Result printing with clear labels
- Script execution: Standard `if __name__ == "__main__":` guard
- Example:
```python
def main():
    """Main function to run the solution."""
    import sys
    from src.commons.file_parser import parse_input_file

    if len(sys.argv) != 2:
        print("Usage: python day1.py <input_file>")
        sys.exit(1)
    
    filename = sys.argv[1]
    lines = parse_input_file(filename)
    
    part1_result = solve_part1(lines)
    part2_result = solve_part2(lines)
    
    print(f"Part 1: {part1_result}")
    print(f"Part 2: {part2_result}")

if __name__ == "__main__":
    main()
```

### Error Handling Practices
- Graceful degradation for edge cases without crashing
- Descriptive error messages with context
- SystemExit patterns for file operations (in file_parser module)
- ValueError with helpful messages for invalid inputs

### Testing Conventions
- **MANDATORY**: All days must have tests for part 1 and part 2 results
- Each test file (`test_day{N}.py`) must contain exactly two tests:
  - `test_part1()`: Test part 1 result with demo input
  - `test_part2()`: Test part 2 result with demo input
- No additional tests beyond these two requirements
- Test structure:
```python
def test_part1():
    """Test Part 1 solution with demo input."""
    from src.commons.file_parser import parse_input_file
    lines = parse_input_file('src/days/day1/demo.txt')
    result = solve_part1(lines)
    assert result == expected_value
```

## Conventions
- High-level architectural patterns and project organization principles

## Git Workflow
- **MANDATORY**: Git workflow should be included in ANY PLAN MADE
- **MANDATORY**: Git workflow must be followed through during ANY IMPLEMENTATION

1. **Pre-feature setup**: Check for uncommitted files. If found, ask user to revert to HEAD
2. **Branch management**: Switch to main branch and pull latest changes
3. **Feature branch**: Create `feature/{feature-name}` branch
4. **Incremental commits**: Commit and push after each stage/step
5. **PR creation**: Create GitHub PR with description when feature is complete

**Available tools**: `git` and `gh` commands
