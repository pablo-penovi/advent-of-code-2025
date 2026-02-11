from src.commons.file_parser import parse_input_file
from src.days.day3.day3 import solve_part1, solve_part2


def test_part1():
    lines = parse_input_file('src/days/day3/demo.txt')
    result = solve_part1(lines)
    assert result == 357


def test_part2():
    lines = parse_input_file('src/days/day3/demo.txt')
    result = solve_part2(lines)
    # assert result == expected_value  # To be filled when puzzle available