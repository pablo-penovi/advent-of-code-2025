"""Tests for Day 2 Advent of Code 2025 solution."""

import pytest
from src.days.day2.day2 import solve_part1, solve_part2


def test_part1():
    """Test Part 1 solution with demo input."""
    from src.commons.file_parser import parse_input_file
    lines = parse_input_file('src/days/day2/demo.txt')
    result = solve_part1(lines)
    assert result == 1227775554


def test_part2():
    """Test Part 2 solution with demo input."""
    from src.commons.file_parser import parse_input_file
    lines = parse_input_file('src/days/day2/demo.txt')
    result = solve_part2(lines)
    assert result == 4174379265