def parse_range(line: str) -> tuple[int, int]:
    """
    Parse a range instruction like '3-5' or '10-14'.
    
    Args:
        line: String containing range instruction
        
    Returns:
        tuple: (start, end) inclusive range
        
    Raises:
        ValueError: If line format is invalid or empty
    """
    line = line.strip()
    if not line:
        raise ValueError("Empty range line")
    
    if '-' not in line:
        raise ValueError(f"Invalid range format: {line}")
    
    parts = line.split('-')
    if len(parts) != 2:
        raise ValueError(f"Invalid range format: {line}")
    
    try:
        start = int(parts[0])
        end = int(parts[1])
    except ValueError:
        raise ValueError(f"Invalid numbers in range: {line}")
    
    if start > end:
        raise ValueError(f"Start cannot be greater than end: {line}")
    
    return start, end


def parse_seed(line: str) -> int:
    """
    Parse a seed number.
    
    Args:
        line: String containing seed number
        
    Returns:
        int: The seed number
        
    Raises:
        ValueError: If line format is invalid or empty
    """
    line = line.strip()
    if not line:
        raise ValueError("Empty seed line")
    
    try:
        return int(line)
    except ValueError:
        raise ValueError(f"Invalid seed number: {line}")


def parse_input_sections(lines: list[str]) -> tuple[list[tuple[int, int]], list[int]]:
    """
    Parse the input into ranges and seeds sections.
    
    Args:
        lines: List of input lines
        
    Returns:
        tuple: (ranges, seeds) where ranges is list of (start, end) tuples
              and seeds is list of integers
        
    Raises:
        ValueError: If input format is invalid
    """
    ranges = []
    seeds = []
    current_section = "ranges"
    
    for line in lines:
        line = line.strip()
        
        if not line:
            current_section = "seeds"
            continue
        
        if current_section == "ranges":
            ranges.append(parse_range(line))
        else:
            seeds.append(parse_seed(line))
    
    return ranges, seeds


def solve_part1(lines: list[str]) -> int:
    """
    Solve Part 1 of Day 5 puzzle.
    
    Args:
        lines: List of input lines
        
    Returns:
        int: Result for part 1
    """
    ranges, seeds = parse_input_sections(lines)
    
    result = 0
    for seed in seeds:
        for range_start, range_end in ranges:
            if range_start <= seed <= range_end:
                result += 1
                break
    
    return result


def solve_part2(lines: list[str]) -> int:
    """
    Solve Part 2 of Day 5 puzzle.
    
    Args:
        lines: List of input lines
        
    Returns:
        int: Result for part 2
    """
    ranges, seeds = parse_input_sections(lines)
    
    result = 0
    for seed in seeds:
        overlaps = 0
        for range_start, range_end in ranges:
            if range_start <= seed <= range_end:
                overlaps += 1
        
        if overlaps >= 2:
            result += 1
    
    return result


def main():
    """Main function to run the solution."""
    import sys
    from src.commons.file_parser import parse_input_file

    if len(sys.argv) != 2:
        print("Usage: python -m src.days.day5.day5 <input_file>")
        sys.exit(1)
    
    filename = sys.argv[1]
    lines = parse_input_file(filename)
    
    part1_result = solve_part1(lines)
    part2_result = solve_part2(lines)
    
    print(f"Part 1: {part1_result}")
    print(f"Part 2: {part2_result}")


if __name__ == "__main__":
    main()