from src.commons.file_parser import parse_input_file


def find_max_joltage(line: str) -> int:
    """
    Find maximum 2-digit number using the proposed O(N) approach.
    
    Args:
        line: String of digits representing battery joltages
        
    Returns:
        Maximum 2-digit number that can be formed
    """
    # Step 1: Find left-most largest digit
    max_digit = '0'
    max_pos = -1
    
    for i, char in enumerate(line):
        if char > max_digit:
            max_digit = char
            max_pos = i
    
    # Step 2: If max is last digit, find second largest (exclude last position)
    if max_pos == len(line) - 1:
        second_max_digit = '0'
        second_max_pos = -1
        
        # Only iterate up to the second to last position (exclusive)
        for i in range(len(line) - 1):
            if line[i] > second_max_digit:
                second_max_digit = line[i]
                second_max_pos = i
        
        max_digit = second_max_digit
        max_pos = second_max_pos
    
    # Step 3: Find largest digit after the chosen digit
    max_after = '0'
    for i in range(max_pos + 1, len(line)):
        if line[i] > max_after:
            max_after = line[i]
    
    # Step 4: Form and return the 2-digit number
    return int(max_digit + max_after)


def solve_part1(input_lines: list[str]) -> int:
    """
    Solve Part 1 of Day 3: Calculate total output joltage.
    
    Args:
        input_lines: List of strings, each representing a bank of batteries
        
    Returns:
        Sum of maximum joltage from each bank
    """
    total_joltage = 0
    
    for line in input_lines:
        line = line.strip()
        if not line:
            continue
        total_joltage += find_max_joltage(line)
    
    return total_joltage


def solve_part2(input_lines: list[str]) -> int:
    """Solve Part 2 of Day 3."""
    pass  # To be implemented when puzzle available


def main():
    """Main function for running Day 3 solutions."""
    pass