"""Day 4 Advent of Code 2025 solution.

This module contains solutions for counting accessible paper rolls
based on adjacent roll density in the printing department grid.
"""


def count_adjacent_rolls(grid: list[str], row: int, col: int) -> int:
    """
    Count the number of paper rolls in the 8 adjacent positions.
    
    Args:
        grid: 2D grid representation where '@' is a paper roll
        row: Row index of the position to check
        col: Column index of the position to check
        
    Returns:
        Number of '@' symbols in the 8 adjacent positions
    """
    adjacent_count = 0
    
    # 8 directional offsets: (row_offset, col_offset)
    directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), 
                  (0, 1), (1, -1), (1, 0), (1, 1)]
    
    for row_offset, col_offset in directions:
        new_row = row + row_offset
        new_col = col + col_offset
        
        # Check boundaries
        if 0 <= new_row < len(grid) and 0 <= new_col < len(grid[0]):
            if grid[new_row][new_col] == '@':
                adjacent_count += 1
    
    return adjacent_count


def solve_part1(input_lines: list[str]) -> int:
    """
    Solve Part 1 of Day 4: Count accessible paper rolls.
    
    A paper roll is accessible if there are fewer than four rolls 
    in the eight adjacent positions.
    
    Args:
        input_lines: List of strings representing the grid
        
    Returns:
        Number of accessible paper rolls
    """
    if not input_lines:
        return 0
    
    accessible_count = 0
    
    for row in range(len(input_lines)):
        for col in range(len(input_lines[0])):
            if input_lines[row][col] == '@':
                adjacent_rolls = count_adjacent_rolls(input_lines, row, col)
                if adjacent_rolls < 4:
                    accessible_count += 1
    
    return accessible_count


def solve_part2(input_lines: list[str]) -> int:
    """
    Solve Part 2 of Day 4: Placeholder for future implementation.
    
    Args:
        input_lines: List of strings representing the grid
        
    Returns:
        Placeholder value (0 for now)
    """
    return 0


def main():
    """Main function to run the solution."""
    import sys
    from src.commons.file_parser import parse_input_file

    if len(sys.argv) != 2:
        print("Usage: python day4.py <input_file>")
        sys.exit(1)
    
    filename = sys.argv[1]
    lines = parse_input_file(filename)
    
    part1_result = solve_part1(lines)
    part2_result = solve_part2(lines)
    
    print(f"Part 1: {part1_result}")
    print(f"Part 2: {part2_result}")


if __name__ == "__main__":
    main()