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


def count_adjacent_rolls_with_edges(grid: list[list[str]], row: int, col: int) -> int:
    """
    Count the number of paper rolls in adjacent positions within grid bounds.
    
    Edge positions outside the grid are treated as empty and not counted.
    
    Args:
        grid: 2D grid representation where '@' is a paper roll
        row: Row index of the position to check
        col: Column index of the position to check
        
    Returns:
        Number of '@' symbols in adjacent positions within grid bounds
    """
    adjacent_count = 0
    
    # 8 directional offsets: (row_offset, col_offset)
    directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), 
                  (0, 1), (1, -1), (1, 0), (1, 1)]
    
    for row_offset, col_offset in directions:
        new_row = row + row_offset
        new_col = col + col_offset
        
        # Only count positions within grid bounds
        if 0 <= new_row < len(grid) and 0 <= new_col < len(grid[0]):
            if grid[new_row][new_col] == '@':
                adjacent_count += 1
    
    return adjacent_count


def find_accessible_rolls(grid: list[list[str]]) -> list[tuple[int, int]]:
    """
    Find all currently accessible rolls (fewer than 4 adjacent rolls).
    
    Args:
        grid: 2D grid representation where '@' is a paper roll
        
    Returns:
        List of (row, col) tuples for accessible rolls
    """
    accessible_rolls = []
    
    for row in range(len(grid)):
        for col in range(len(grid[0])):
            if grid[row][col] == '@':
                adjacent_count = count_adjacent_rolls_with_edges(grid, row, col)
                if adjacent_count < 4:
                    accessible_rolls.append((row, col))
    
    return accessible_rolls


def solve_part2(input_lines: list[str]) -> int:
    """
    Solve Part 2 of Day 4: Count total removable rolls through iterative removal.
    
    Rolls are repeatedly removed if they have fewer than 4 adjacent rolls,
    counting edge positions as empty. Process continues until no more rolls
    are accessible.
    
    Args:
        input_lines: List of strings representing the grid
        
    Returns:
        Total number of rolls that can be removed
    """
    if not input_lines:
        return 0
    
    # Convert to mutable grid
    grid = [list(line) for line in input_lines]
    total_removed = 0
    
    while True:
        # Find all currently accessible rolls
        accessible_rolls = find_accessible_rolls(grid)
        
        # No more accessible rolls, stop
        if not accessible_rolls:
            break
        
        # Remove all accessible rolls
        for row, col in accessible_rolls:
            grid[row][col] = '.'
        
        total_removed += len(accessible_rolls)
    
    return total_removed


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