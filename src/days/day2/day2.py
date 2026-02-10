def parse_ranges(input_line: str) -> list[tuple[str, str]]:
    """
    Parse comma-separated ranges into list of (start, end) string tuples.
    
    Args:
        input_line: Single line with comma-separated ranges like "11-22,95-115"
        
    Returns:
        List of tuples where each tuple contains (start_str, end_str)
    """
    ranges = []
    for range_part in input_line.split(','):
        range_part = range_part.strip()
        if not range_part:
            continue
        start_end = range_part.split('-')
        if len(start_end) != 2:
            continue
        ranges.append((start_end[0].strip(), start_end[1].strip()))
    return ranges


def is_invalid_id(num_str: str) -> bool:
    """
    Check if number string follows repeated pattern (XX format).
    
    Args:
        num_str: Number as string
        
    Returns:
        True if the number is invalid (repeated pattern), False otherwise
    """
    # Odd length numbers are automatically valid
    if len(num_str) % 2 != 0:
        return False
    
    # Even length numbers: split exactly in middle and compare halves
    mid = len(num_str) // 2
    return num_str[:mid] == num_str[mid:]


def solve_part1(input_lines: list[str]) -> int:
    """
    Solve Part 1 of Day 2: Find and sum all invalid IDs in ranges.
    
    Args:
        input_lines: List containing a single line with comma-separated ranges
        
    Returns:
        Sum of all invalid IDs found in the given ranges
    """
    if not input_lines:
        return 0
    
    # Parse ranges from the first line
    input_line = input_lines[0].strip()
    ranges = parse_ranges(input_line)
    
    total_sum = 0
    
    for start_str, end_str in ranges:
        # Convert to integers only for range iteration
        start_num = int(start_str)
        end_num = int(end_str)
        
        # Iterate through each number in the range
        for num in range(start_num, end_num + 1):
            # Convert back to string for validation
            num_str = str(num)
            if is_invalid_id(num_str):
                total_sum += num
    
    return total_sum


def solve_part2(input_lines: list[str]) -> int:
    """
    Placeholder for Part 2 solution.
    
    Args:
        input_lines: List containing input data
        
    Returns:
        Part 2 result (placeholder)
    """
    # Part 2 implementation will go here
    return 0


def main():
    """Main function to run the solution."""
    import sys
    from src.commons.file_parser import parse_input_file

    if len(sys.argv) != 2:
        print("Usage: python day2.py <input_file>")
        sys.exit(1)
    
    filename = sys.argv[1]
    lines = parse_input_file(filename)
    
    part1_result = solve_part1(lines)
    part2_result = solve_part2(lines)
    
    print(f"Part 1: {part1_result}")
    print(f"Part 2: {part2_result}")


if __name__ == "__main__":
    main()