# UI Agents

This file contains specialized information for agents working on UI tasks in the Advent of Code 2025 Zig project. UI agents focus exclusively on user interface components, visual design, and user interaction patterns.

## UI Agent Responsibilities

### Scope of Work
UI agents are responsible for:
- **TUI Widget Development**: Creating and modifying Vaxis widgets
- **User Interface Design**: Layout, styling, and visual hierarchy
- **Event Handling**: User input processing and interaction feedback
- **Navigation Systems**: Keyboard navigation, focus management
- **Visual Feedback**: Cursors, highlighting, status indicators
- **Responsive Design**: Adapting to different terminal sizes

### Exclusions
UI agents should NOT handle:
- Business logic implementation
- Data processing algorithms
- File I/O operations
- Network communication
- Core application state management

## UI Technology Stack

### Vaxis TUI Framework
- **Version**: 0.5.1
- **Import Pattern**: `const vaxis = @import("vaxis"); const vxfw = vaxis.vxfw;`
- **Core Components**: Widgets, Events, Surfaces, DrawContext

### Key UI Files
- `src/main.zig` - Main TUI application with DaySelector widget
- Future UI components in `src/ui/` (if created)

## UI Patterns and Conventions

### Widget Structure
```zig
const MyWidget = struct {
    allocator: std.mem.Allocator,
    // UI-specific state only
    
    pub fn widget(self: *MyWidget) vxfw.Widget {
        return .{
            .userdata = self,
            .eventHandler = typeErasedEventHandler,
            .drawFn = typeErasedDrawFn,
        };
    }
};
```

### Event Handling Patterns
- **Keyboard Navigation**: Arrow keys, Enter, Escape, Ctrl+C/Q
- **Focus Management**: Proper focus requests and transfers
- **Event Consumption**: Use `ctx.consumeAndRedraw()` for UI updates

### Drawing and Layout
- **Constraint-based Layout**: Use `ctx.max` and `ctx.min` for responsive design
- **Arena Allocation**: Use `ctx.arena` for temporary drawing allocations
- **SubSurface Positioning**: Relative positioning within parent containers

## UI-Specific Best Practices

### Memory Management
- Use arena allocators for drawing operations
- Implement proper `deinit()` for widget cleanup
- Avoid memory leaks in UI components

### User Experience
- Provide clear visual feedback for interactions
- Support keyboard navigation for all functionality
- Handle terminal resizing gracefully
- Follow platform conventions (Ctrl+C to quit)

### Visual Design
- Use consistent styling (colors, bold, emphasis)
- Implement clear visual hierarchy
- Provide appropriate spacing and alignment
- Use dividers and borders for organization

## UI Testing Strategy

### Manual Testing
- Test with various terminal sizes
- Verify keyboard navigation flows
- Check focus management
- Test resize behavior

### Automated Testing
- Test widget initialization/cleanup
- Verify event handling logic
- Test memory allocation patterns

## Integration with Application Logic

### Data Separation
UI components should:
- Accept data through constructor parameters
- Emit events for user actions
- Not implement business logic directly
- Delegate complex operations to application logic

### Event Communication
- Use standard Vaxis event patterns
- Emit custom events for application-specific actions
- Handle focus changes appropriately
- Provide visual feedback for all interactions

## Common UI Tasks

### Widget Creation
- Implement `vxfw.Widget` interface
- Handle initialization and cleanup
- Manage widget state properly
- Provide consistent event handling

### Layout Implementation
- Use constraint-based positioning
- Handle responsive design requirements
- Implement proper child widget placement
- Account for borders and padding

### Navigation Systems
- Implement keyboard navigation
- Manage focus transfers
- Handle selection and activation
- Provide clear visual indicators

## UI Agent Workflow

### Development Process
1. **Understand Requirements**: Focus on user interaction and visual design
2. **Implement UI Components**: Create widgets following established patterns
3. **Test User Experience**: Verify navigation, responsiveness, and visual feedback
4. **Integrate with Logic**: Ensure proper communication with application logic
5. **Commit Changes**: Follow git workflow with descriptive commit messages

### Quality Assurance
- Test UI components in isolation
- Verify integration with application logic
- Check memory management
- Ensure responsive behavior

## Coordination with Application Logic Agents

### Handoff Points
- UI agents define widget interfaces and event patterns
- Application logic agents implement business logic and data handling
- Clear separation through event-based communication

### Communication Protocol
- UI agents specify required data structures
- Application logic agents provide data access methods
- Both agents agree on event patterns for user actions

## UI-Specific Files and Skills

### Referenced Skills
- `skills/ui/SKILL.md` - Comprehensive Vaxis TUI widget patterns
- `skills/git/SKILL.md` - Git workflow for version control
- **AI AGENTS MUST ONLY USE THESE TWO SKILLS** - No other skills should be used by AI agents

### AI Agent Restrictions
**CRITICAL**: AI agents working on UI tasks MUST use ONLY:
1. `skills/ui/SKILL.md` for all UI-related work
2. `skills/git/SKILL.md` for all version control operations

AI agents MUST NOT use any other skills or attempt to handle application logic tasks.

### Key UI Documentation
- Widget implementation patterns
- Event handling guidelines
- Drawing and layout conventions
- Memory management for UI components

UI agents should focus exclusively on creating intuitive, responsive user interfaces while maintaining clear separation from application logic concerns.