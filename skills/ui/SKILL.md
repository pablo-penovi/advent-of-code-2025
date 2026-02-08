# UI Skill

This skill provides comprehensive information for agents working with Vaxis TUI widgets in this project. It covers the patterns, conventions, and best practices for creating or implementing user interface components.

## Vaxis Framework Overview

### Version and Configuration
- **Vaxis Version**: 0.5.1
- **Import Pattern**: 
  ```zig
  const vaxis = @import("vaxis");
  const vxfw = vaxis.vxfw;
  ```

### Core Concepts
- **Widgets**: UI components that implement the `vxfw.Widget` interface
- **Event Handling**: Event-driven architecture with `eventHandler` functions
- **Drawing**: Constraint-based drawing system with `DrawContext`
- **Surfaces**: Drawing areas with size, position, and child surfaces

## Widget Implementation Patterns

### Basic Widget Structure
```zig
const MyWidget = struct {
    // Widget state
    allocator: std.mem.Allocator,
    // Other fields...

    pub fn init(allocator: std.mem.Allocator) !*MyWidget {
        const self = try allocator.create(MyWidget);
        self.* = .{
            .allocator = allocator,
            // Initialize other fields...
        };
        return self;
    }

    pub fn deinit(self: *MyWidget) void {
        // Clean up allocated resources
        self.allocator.destroy(self);
    }

    pub fn widget(self: *MyWidget) vxfw.Widget {
        return .{
            .userdata = self,
            .eventHandler = typeErasedEventHandler,
            .drawFn = typeErasedDrawFn,
        };
    }

    fn typeErasedEventHandler(ptr: *anyopaque, ctx: *vxfw.EventContext, event: vxfw.Event) anyerror!void {
        const self: *MyWidget = @ptrCast(@alignCast(ptr));
        // Handle events...
    }

    fn typeErasedDrawFn(ptr: *anyopaque, ctx: vxfw.DrawContext) std.mem.Allocator.Error!vxfw.Surface {
        const self: *MyWidget = @ptrCast(@alignCast(ptr));
        // Draw widget...
    }
};
```

## Event Handling

### Event Types
- **`.init`**: First event sent to root widget
- **`.key_press`**: Keyboard input
- **`.focus_in`**: Widget receives focus
- **`.focus_out`**: Widget loses focus
- **`.mouse`**: Mouse events (click, motion, scroll)

### Common Event Patterns
```zig
fn typeErasedEventHandler(ptr: *anyopaque, ctx: *vxfw.EventContext, event: vxfw.Event) anyerror!void {
    const self: *MyWidget = @ptrCast(@alignCast(ptr));
    switch (event) {
        .init => return ctx.requestFocus(self.child.widget()),
        .key_press => |key| {
            if (key.matches('c', .{ .ctrl = true }) or key.matches('q', .{})) {
                ctx.quit = true;
                return;
            }
            if (key.matches(vaxis.Key.enter, .{})) {
                // Handle Enter key
                return ctx.consumeAndRedraw();
            }
            // Handle other keys...
        },
        .focus_in => return ctx.requestFocus(self.child.widget()),
        else => return self.child.handleEvent(ctx, event),
    }
}
```

### Keyboard Shortcuts
- **Ctrl+C / Q**: Quit application
- **Enter**: Confirm selection
- **Arrow Keys**: Navigation
- **Escape**: Cancel/Go back

## Drawing System

### DrawContext Constraints
```zig
fn typeErasedDrawFn(ptr: *anyopaque, ctx: vxfw.DrawContext) std.mem.Allocator.Error!vxfw.Surface {
    const self: *MyWidget = @ptrCast(@alignCast(ptr));
    const max_size = ctx.max.size();
    
    // Use constraints for responsive layout
    const child_ctx = ctx.withConstraints(
        ctx.min,
        .{ .width = max_size.width - 4, .height = max_size.height - 5 }
    );
    
    // Draw children...
}
```

### Surface Creation
```zig
return .{
    .size = max_size,
    .widget = self.widget(),
    .buffer = &.{}, // Empty buffer for container widgets
    .children = children, // Slice of SubSurface
};
```

### SubSurface Positioning
```zig
const child_surface: vxfw.SubSurface = .{
    .origin = .{ .row = row, .col = col },
    .surface = try child.draw(ctx),
};
```

## Common Widget Types

### Text Widget
```zig
const text: vxfw.Text = .{ 
    .text = "Hello World",
    .style = .{ .bold = true, .fg = .{ .index = 2 } }
};
```

### List View
```zig
const list_view: vxfw.ListView = .{
    .children = .{ .slice = widgets },
    .draw_cursor = true,
    .wheel_scroll = 3,
};
```

### Container Layout
```zig
// Create children array
const children = try ctx.arena.alloc(vxfw.SubSurface, child_count);
children[0] = title_child;
children[1] = content_child;

return .{
    .size = max_size,
    .widget = self.widget(),
    .buffer = &.{},
    .children = children,
};
```

## Memory Management

### Allocation Patterns
- **Arena Allocators**: Use `ctx.arena` for temporary allocations (drawing)
- **General Purpose Allocator**: Use widget's allocator for persistent state
- **Cleanup**: Always implement `deinit()` to free allocated resources

### Example Memory Management
```zig
pub fn init(allocator: std.mem.Allocator) !*MyWidget {
    const self = try allocator.create(MyWidget);
    self.* = .{
        .allocator = allocator,
        .text = try allocator.alloc(u8, 100),
    };
    return self;
}

pub fn deinit(self: *MyWidget) void {
    self.allocator.free(self.text);
    self.allocator.destroy(self);
}
```

## Project-Specific Patterns

### Day Selector Pattern
The project uses a specific pattern for day selection:

```zig
// Create day widgets (1-25)
var day_widgets = try allocator.alloc(vxfw.Widget, 25);
var day_texts = try allocator.alloc([]const u8, 25);
for (1..26) |day| {
    const day_text = try std.fmt.allocPrint(allocator, "Day {d}", .{day});
    const text_widget: vxfw.Text = .{ .text = day_text };
    day_widgets[day - 1] = text_widget.widget();
    day_texts[day - 1] = day_text;
}
```

### Title and Divider Pattern
```zig
// Title
const title: vxfw.Text = .{ 
    .text = "Advent of Code 2025", 
    .style = .{ .bold = true } 
};

// Divider (full width)
const divider_text = try ctx.arena.alloc(u8, max_size.width);
for (divider_text) |*char| {
    char.* = '-';
}
const divider: vxfw.Text = .{ .text = divider_text };
```

## Layout Guidelines

### Responsive Design
- Use `ctx.max.size()` to get available space
- Implement minimum constraints with `ctx.min`
- Create flexible layouts that adapt to terminal size

### Positioning
- Use relative positioning within parent constraints
- Account for borders and padding
- Center titles: `@divTrunc(max_size.width - title_width, 2)`

### Spacing
- Leave at least 1-2 characters for borders
- Use consistent spacing between elements
- Consider terminal font dimensions

## Testing UI Components

### Manual Testing
- Test with different terminal sizes
- Verify keyboard navigation
- Check focus management
- Test resize behavior

### Automated Testing
- Test widget initialization and cleanup
- Verify event handling logic
- Test memory allocation/deallocation

## Integration with Application

### App Initialization
```zig
var app = try vxfw.App.init(allocator);
defer app.deinit();

try app.run(main_widget.widget(), .{});
```

### Event Loop
- The Vaxis runtime handles the main event loop
- Widgets respond to events through their event handlers
- Redraws are triggered by `ctx.consumeAndRedraw()`

## Best Practices

### Performance
- Use arena allocators for drawing operations
- Minimize allocations in hot paths
- Cache expensive calculations

### User Experience
- Provide clear visual feedback
- Support keyboard navigation
- Handle edge cases (empty lists, invalid input)
- Follow platform conventions (Ctrl+C to quit)

### Code Organization
- Separate widget logic from business logic
- Use clear, descriptive function names
- Document complex event handling logic
- Follow existing naming conventions

## Common Issues and Solutions

### Memory Leaks
- Always free allocated strings and arrays
- Use proper cleanup in `deinit()`
- Test with GeneralPurposeAllocator leak detection

### Focus Issues
- Request focus appropriately in `.init` event
- Handle `.focus_in` events properly
- Ensure only one widget has focus at a time

### Drawing Problems
- Respect size constraints
- Handle null maximum sizes properly
- Use SubSurface for child positioning

## Debugging Tips

### Logging
- Use `std.log.info()` for debugging
- Log event types and key presses
- Track widget state changes

### Visual Debugging
- Add temporary text to show widget state
- Use different colors for debugging
- Draw borders around widgets to verify layout

This UI skill provides the foundation for creating effective Vaxis TUI widgets while maintaining consistency with the project's existing patterns and conventions.