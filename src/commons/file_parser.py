"""File parsing utilities for Advent of Code 2025 solutions."""


def parse_input_file(filename: str) -> list[str]:
    """
    Parse input file and return list of lines without newlines.
    
    Args:
        filename: Path to the input file
        
    Returns:
        List of strings, each representing a line without trailing newlines
        
    Raises:
        SystemExit: If file not found or error occurs
    """
    import sys
    
    try:
        with open(filename, 'r') as f:
            return [line.rstrip('\n\r') for line in f]
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading file '{filename}': {e}")
        sys.exit(1)