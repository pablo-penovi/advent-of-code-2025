def parse_rotation(line: str) -> tuple[str, int]:
    """
    Parse a rotation instruction like 'L68' or 'R48'.
    
    Returns:
        tuple: (direction, distance) where direction is 'L' or 'R'
    """
    line = line.strip()
    if not line:
        raise ValueError("Empty rotation line")
    
    direction = line[0].upper()
    if direction not in ('L', 'R'):
        raise ValueError(f"Invalid direction: {direction}")
    
    try:
        distance = int(line[1:])
    except ValueError:
        raise ValueError(f"Invalid distance in: {line}")
    
    return direction, distance


def apply_rotation(current: int, direction: str, distance: int) -> int:
    """
    Apply a rotation to the current dial position.
    
    Args:
        current: Current dial position (0-99)
        direction: 'L' for left, 'R' for right
        distance: Number of clicks to rotate
        
    Returns:
        New dial position (0-99)
    """
    if direction == 'L':
        return (current - distance) % 100
    else:  # 'R'
        return (current + distance) % 100


def solve_part1(input_lines: list[str]) -> int:
    """
    Solve Part 1 of Day 1: Count how many times dial points at 0.
    
    Args:
        input_lines: List of rotation instructions
        
    Returns:
        Number of times dial ends up at position 0
    """
    position = 50  # Starting position
    zero_count = 0
    
    for line in input_lines:
        line = line.strip()
        if not line:  # Skip empty lines
            continue
            
        direction, distance = parse_rotation(line)
        position = apply_rotation(position, direction, distance)
        
        if position == 0:
            zero_count += 1
    
    return zero_count


def solve_part2(input_lines: list[str]) -> int:
    """
    Placeholder for Part 2 solution.
    
    Args:
        input_lines: List of rotation instructions
        
    Returns:
        Part 2 result (placeholder)
    """
    # Part 2 implementation will go here
    return 0


def main():
    """Main function to run the solution."""
    import sys
    from ..commons.file_parser import parse_input_file

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
