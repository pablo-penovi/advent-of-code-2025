"""Tests for Day 3 Advent of Code 2025 solution."""

import pytest
from src.days.day3.day3 import solve_part1, solve_part2


def test_part1():
    """Test Part 1 solution with demo input."""
    from src.commons.file_parser import parse_input_file
    lines = parse_input_file('src/days/day3/demo.txt')
    result = solve_part1(lines)
    assert result == 357


def test_part2():
    """Test Part 2 solution with demo input."""
    from src.commons.file_parser import parse_input_file
    lines = parse_input_file('src/days/day3/demo.txt')
    result = solve_part2(lines)
    assert result == 3121910778619