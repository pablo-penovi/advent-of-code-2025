# Application Logic Agents

This file contains specialized information for agents working on application logic tasks in the Advent of Code 2025 Zig project. Application logic agents focus exclusively on business logic, data processing, algorithms, and core functionality.

## Application Logic Agent Responsibilities

### Scope of Work
Application logic agents are responsible for:
- **Business Logic Implementation**: Core application rules and behaviors
- **Data Processing**: Algorithms, transformations, and computations
- **State Management**: Application state and data structures
- **File I/O Operations**: Reading, writing, and file system interactions
- **Algorithm Development**: Problem-solving and computational logic
- **Data Structures**: Efficient data organization and access patterns

### Exclusions
Application logic agents should NOT handle:
- UI widget implementation
- Visual design and styling
- User interface event handling
- Keyboard navigation implementation
- Terminal-specific display logic

## Application Logic Technology Stack

### Zig Language Features
- **Version**: 0.15.2
- **Memory Management**: `std.heap.GeneralPurposeAllocator`, arena allocators
- **Error Handling**: Standard Zig error propagation with `!` return types
- **Module System**: Separate modules for library vs executable functionality

### Key Logic Files
- `src/root.zig` - Library module with utility functions and business logic
- Future logic modules in `src/logic/` or `src/core/` (if created)

## Application Logic Patterns and Conventions

### Function Structure
```zig
pub fn processData(allocator: std.mem.Allocator, input: []const u8) !ProcessedData {
    // Implementation logic here
    // Return error types appropriately
}
```

### Error Handling Patterns
- Use Zig's error union types: `!ReturnType`
- Define specific error sets for different operations
- Propagate errors with `try` keyword
- Handle cleanup in defer blocks where needed

### Memory Management
- Use `GeneralPurposeAllocator` for persistent allocations
- Use arena allocators for temporary computations
- Implement proper cleanup in `deinit()` functions
- Follow RAII patterns where possible

## Logic-Specific Best Practices

### Algorithm Design
- Choose appropriate data structures for the problem
- Consider time and space complexity
- Implement efficient solutions for Advent of Code challenges
- Use standard library functions when available

### Data Processing
- Handle input validation and edge cases
- Process data in memory-efficient ways
- Use streaming approaches for large inputs
- Implement proper error handling for malformed data

### State Management
- Keep application state in well-defined structures
- Use immutable data patterns where appropriate
- Implement clear state transition logic
- Avoid global variables when possible

## Application Logic Testing Strategy

### Unit Testing
- Test individual functions in isolation
- Verify algorithm correctness with known inputs
- Test error handling paths
- Check edge cases and boundary conditions

### Integration Testing
- Test interaction between multiple logic components
- Verify data flow through processing pipelines
- Test file I/O operations
- Check memory management and cleanup

### Performance Testing
- Benchmark algorithm performance
- Test with large input sizes
- Verify memory usage patterns
- Check for memory leaks

## Common Application Logic Tasks

### Data Structure Implementation
- Design efficient data structures for specific problems
- Implement custom collection types when needed
- Use standard library collections appropriately
- Optimize for the specific use case

### Algorithm Development
- Implement problem-solving algorithms
- Optimize for performance and memory usage
- Handle edge cases and error conditions
- Document algorithmic complexity

### File Processing
- Read and parse input files efficiently
- Handle different file formats and encodings
- Implement streaming processing for large files
- Provide clear error messages for file issues

### Mathematical Computations
- Implement numerical algorithms accurately
- Handle integer overflow and precision issues
- Use appropriate numeric types
- Validate mathematical operations

## Application Logic Agent Workflow

### Development Process
1. **Analyze Requirements**: Focus on business rules and data processing needs
2. **Design Algorithms**: Choose appropriate approaches and data structures
3. **Implement Logic**: Write clean, efficient code following Zig patterns
4. **Test Thoroughly**: Verify correctness, performance, and error handling
5. **Document Interfaces**: Provide clear API documentation
6. **Commit Changes**: Follow git workflow with descriptive commit messages

### Quality Assurance
- Write comprehensive unit tests
- Verify algorithm correctness with test cases
- Check memory management and performance
- Ensure proper error handling

## Coordination with UI Agents

### Interface Definition
- Application logic agents define clear function interfaces
- Provide data structures that UI components can consume
- Implement event handlers for UI-triggered actions
- Document API contracts clearly

### Data Flow
- Logic agents process data and provide results to UI
- Handle state changes that UI needs to reflect
- Provide validation and error information for display
- Maintain separation between data and presentation

### Communication Protocol
- Define clear function signatures for UI integration
- Provide callback mechanisms for async operations
- Handle UI events through defined interfaces
- Maintain loose coupling between layers

## Logic-Specific Files and Skills

### Referenced Skills
- `skills/git/SKILL.md` - Git workflow for version control
- Future logic-specific skills may be added in `skills/logic/`

### Key Logic Documentation
- Function interface specifications
- Data structure definitions
- Algorithm documentation
- Error handling patterns

## Advent of Code Specific Considerations

### Challenge Patterns
- Each day typically involves parsing input and computing results
- Problems often require custom data structures
- Performance matters for large input datasets
- Solutions should be testable with examples

### Implementation Approach
- Start with simple, correct solutions
- Optimize for performance if needed
- Handle edge cases from problem descriptions
- Provide clear error messages for invalid inputs

### Testing Strategy
- Test with provided examples
- Create additional test cases for edge conditions
- Verify both parts of each day's challenge
- Test performance with large inputs

Application logic agents should focus exclusively on implementing correct, efficient business logic while maintaining clear interfaces for UI integration.