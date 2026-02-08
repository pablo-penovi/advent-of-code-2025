# AGENTS.md

This file contains important information for agents working on the Advent of Code 2025 Zig project.

## Agent Specialization

**CRITICAL**: This project uses specialized agents for different aspects of development. Agents MUST work exclusively in their domain:

- **UI Tasks**: Use `AGENTS_UI.md` for all user interface work
- **Application Logic Tasks**: Use `AGENTS_LOGIC.md` for all business logic work

**No agent should handle both UI and application logic in the same task.** Use separate agents for these two aspects and ensure proper coordination between them.

## AI Agent Skill Restrictions

**CRITICAL**: AI agents MUST use ONLY the following skills:
- **`skills/ui/SKILL.md`** - For all UI-related work (UI agents only)
- **``skills/git/SKILL.md`** - For all version control operations (all agents)

AI agents MUST NOT:
- Use any other skills beyond ui and git
- Handle both UI and application logic in the same task
- Create or use additional skills without explicit approval
- Attempt to work outside their designated domain

## Project Overview

This is a Zig-based TUI (Terminal User Interface) application for Advent of Code 2025 challenges. The project uses the Vaxis TUI framework to create an interactive day selector interface.

- **Project Name**: Advent of Code 2025 (aoc2025)
- **Technology Stack**: Zig 0.15.2 + Vaxis TUI v0.5.1
- **Application Type**: Interactive TUI day selector
- **Purpose**: Provide a terminal-based interface for selecting and navigating through Advent of Code daily challenges

## Development Environment

### Zig Version Requirements
- **Minimum Zig Version**: 0.15.2
- **Current Zig Version**: 0.15.2
- **Compatibility**: Project requires Zig 0.15.2 or later

### Dependencies
- **Vaxis TUI Library**: v0.5.1
- **Git Repository**: https://github.com/rockorager/libvaxis.git
- **Commit Hash**: 8a9c2d5e1b3778f1ea43c9bd5d325cfa72016584
- **Dependency Hash**: vaxis-0.5.1-BWNV_Bw_CQAIVNh1ekGVzbip25CYBQ_J3kgABnYGFnI4

## Project Structure

### Key Files
- `src/main.zig` - Main TUI application entry point with DaySelector implementation
- `src/root.zig` - Library module with utility functions and tests
- `build.zig` - Build configuration and dependency management
- `build.zig.zon` - Package metadata and dependency declarations
- `AGENTS.md` - This file (agent documentation)

### Module Organization
- **Executable Module**: `src/main.zig` - Contains the TUI application logic
- **Library Module**: `src/root.zig` - Contains reusable functions and test utilities
- **Separation of Concerns**: Business logic separated from CLI interface

### Entry Points
- **Main Application**: `src/main.zig:main()` - TUI day selector interface
- **Library Functions**: `src/root.zig` - Utility functions like `bufferedPrint()` and `add()`

## Build & Development Commands

### Standard Commands
```bash
# Run the TUI application
zig build run

# Build the project
zig build

# Run all tests (both library and executable tests)
zig build test

# Run with arguments
zig build run -- arg1 arg2
```

### Development Workflow
1. Make changes to source files
2. Test with `zig build test`
3. Run application with `zig build run`
4. Commit and push changes (see Agent Workflow Requirements)

## Dependencies

### Vaxis TUI Library
The project uses Vaxis for creating the terminal user interface. Key details:

- **Version**: 0.5.1
- **Import Pattern**: `const vaxis = @import("vaxis"); const vxfw = vaxis.vxfw;`
- **Usage**: TUI widgets, event handling, drawing context
- **Integration**: Added to executable module in `build.zig:92`

### Dependency Management
Dependencies are managed through `build.zig.zon`. To update dependencies:

1. Update the URL and hash in `build.zig.zon`
2. Run `zig build --fetch` to fetch updated dependencies
3. Test the changes with `zig build test`

## Code Conventions

### Zig-Specific Patterns
- **Memory Management**: Uses `std.heap.GeneralPurposeAllocator` for main application
- **Error Handling**: Standard Zig error propagation with `try` and `!void` return types
- **Module System**: Separate modules for library vs executable functionality
- **Testing**: Built-in test blocks with `std.testing.expect`

### TUI Application Structure
- **Widget Pattern**: Custom widgets implement `vxfw.Widget` interface
- **Event Handling**: Event-driven architecture with `eventHandler` functions
- **Drawing**: Constraint-based drawing system with `DrawContext`
- **State Management**: Application state managed within widget structs

### Memory Management Notes
- Main application uses `GeneralPurposeAllocator` with leak detection
- Arena allocators used for temporary allocations in drawing functions
- Proper cleanup in `deinit()` functions for allocated resources
- Buffer management for stdout operations

### Event Handling Patterns
- Switch-based event processing in `eventHandler` functions
- Keyboard shortcuts (Ctrl+C, Q for quit, Enter for selection)
- Focus management through `EventContext.requestFocus()`
- Event consumption and redraw requests

## Agent Workflow Requirements

### CRITICAL: Commit and Push Requirements
**Agents MUST commit and push changes after completing each task.** This ensures:

1. **Progress Tracking**: Each completed task is preserved in version control
2. **Collaboration**: Other agents can see and build upon completed work
3. **Accountability**: Clear history of changes and their authors
4. **Backup**: Work is safely stored in remote repository

### Git Workflow
1. **Before Starting**: Pull latest changes with `git pull`
2. **During Work**: Make changes, test with `zig build test`
3. **After Completion**: 
   - Stage changes: `git add .`
   - Commit with descriptive message: `git commit -m "Description of task completed"`
   - Push to remote: `git push`
4. **Verification**: Ensure changes appear in remote repository

### Commit Message Standards
- Use clear, descriptive commit messages
- Focus on what was accomplished, not how
- Reference specific functionality when applicable
- Examples:
  - "Add day selection functionality to TUI interface"
  - "Fix memory leak in DaySelector deinit"
  - "Implement keyboard navigation for list view"

### Branch Management
- Work directly on `main` branch for this project
- If creating branches for complex features, ensure they are merged and pushed
- Keep the remote repository up-to-date at all times

### Quality Assurance
- **Testing**: Always run `zig build test` before committing
- **Functionality**: Verify the application runs correctly with `zig build run`
- **Code Style**: Follow existing Zig conventions and patterns
- **Documentation**: Update relevant documentation when making changes

## Additional Notes

### TUI Application Behavior
- The application displays a list of days 1-25 for Advent of Code
- Users can navigate with arrow keys and select with Enter
- Ctrl+C or Q quits the application
- Selected day is printed to stdout before exit

### Development Tips
- The project uses modern Zig patterns (0.15.2 features)
- Vaxis framework provides robust TUI capabilities
- Memory safety is emphasized with proper cleanup
- Event-driven architecture allows for responsive UI

### Testing Strategy
- Unit tests in library module (`src/root.zig`)
- Integration tests for executable functionality
- Manual testing of TUI interface recommended
- Memory leak detection enabled in debug builds