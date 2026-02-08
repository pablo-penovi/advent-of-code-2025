const std = @import("std");
const vaxis = @import("vaxis");
const vxfw = vaxis.vxfw;

/// Our simple text display application state
const TextDisplay = struct {
    /// Whether we should exit
    should_exit: bool = false,
    /// Allocator for cleanup
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) !*TextDisplay {
        const self = try allocator.create(TextDisplay);
        self.* = .{
            .should_exit = false,
            .allocator = allocator,
        };

        return self;
    }

    pub fn deinit(self: *TextDisplay) void {
        // Free the TextDisplay itself
        self.allocator.destroy(self);
    }

    /// Helper function to return a vxfw.Widget struct
    pub fn widget(self: *TextDisplay) vxfw.Widget {
        return .{
            .userdata = self,
            .eventHandler = typeErasedEventHandler,
            .drawFn = typeErasedDrawFn,
        };
    }

    /// This function will be called from the vxfw runtime.
    fn typeErasedEventHandler(ptr: *anyopaque, ctx: *vxfw.EventContext, event: vxfw.Event) anyerror!void {
        _ = ptr; // unused
        switch (event) {
            // The root widget is always sent an init event as the first event
            .init => return,
            .key_press => |key| {
                if (key.matches('c', .{ .ctrl = true }) or key.matches('q', .{})) {
                    ctx.quit = true;
                    return;
                }
            },
            else => return,
        }
    }

    /// This function is called from the vxfw runtime. It will be called on a regular interval, and
    /// only when any event handler has marked the redraw flag in EventContext as true. By
    /// explicitly requiring setting the redraw flag, vxfw can prevent excessive redraws for events
    /// which don't change state (ie mouse motion, unhandled key events, etc)
    fn typeErasedDrawFn(ptr: *anyopaque, ctx: vxfw.DrawContext) std.mem.Allocator.Error!vxfw.Surface {
        const self: *TextDisplay = @ptrCast(@alignCast(ptr));
        // The DrawContext is inspired from Flutter. Each widget will receive a minimum and maximum
        // constraint. The minimum constraint will always be set, even if it is set to 0x0. The
        // maximum constraint can have null width and/or height - meaning there is no constraint in
        // that direction and the widget should take up as much space as it needs. By
        // explicitly requiring setting the redraw flag, vxfw can prevent excessive redraws for events
        // which don't change state (ie mouse motion, unhandled key events, etc)
        const max_size = ctx.max.size();

        // Create title text
        const title: vxfw.Text = .{ .text = "Advent of Code 2025", .style = .{ .bold = true } };

        // Create horizontal line divider
        const divider_text = try ctx.arena.alloc(u8, max_size.width);
        for (divider_text) |*char| {
            char.* = '-';
        }
        const divider: vxfw.Text = .{ .text = divider_text };

        // Create "Hello world!" text content
        const hello_text: vxfw.Text = .{ .text = "Hello world!" };

        // Each widget returns a Surface from its draw function. A Surface contains the rectangular
        // area of the widget, as well as some information about the surface or widget: can we focus
        // it? does it handle the mouse?
        //
        // It DOES NOT contain the location it should be within its parent. Only the parent can set
        // this via a SubSurface. Here, we will return a Surface for the root widget (TextDisplay), which
        // has three SubSurfaces: title, divider, and hello text. A SubSurface is a Surface
        // with an offset and a z-index - the offset can be negative. This lets a parent draw a
        // child and place it within itself
        const title_child: vxfw.SubSurface = .{
            .origin = .{ .row = 0, .col = @divTrunc(max_size.width - 20, 2) },
            .surface = try title.draw(ctx),
        };

        const divider_child: vxfw.SubSurface = .{
            .origin = .{ .row = 1, .col = 0 },
            .surface = try divider.draw(ctx),
        };

        const hello_child: vxfw.SubSurface = .{
            .origin = .{ .row = 3, .col = @divTrunc(max_size.width - 12, 2) },
            .surface = try hello_text.draw(ctx),
        };

        // We also can use our arena to allocate the slice for our SubSurfaces. This slice only
        // needs to live until the next frame, making this safe.
        const children = try ctx.arena.alloc(vxfw.SubSurface, 3);
        children[0] = title_child;
        children[1] = divider_child;
        children[2] = hello_child;

        return .{
            // A Surface must have a size. Our root widget is the size of the screen
            .size = max_size,
            .widget = self.widget(),
            // We didn't actually need to draw anything for the root. In this case, we can set
            // buffer to a zero length slice. If this slice is *not zero length*, the runtime will
            // assert that its length is equal to the size.width * size.height.
            .buffer = &.{},
            .children = children,
        };
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) {
            std.log.err("memory leak", .{});
        }
    }
    const allocator = gpa.allocator();

    // Initialize Vaxis TUI app
    var app = try vxfw.App.init(allocator);
    defer app.deinit();

    // Create the text display
    var text_display = try TextDisplay.init(allocator);
    defer text_display.deinit();

    // Main event loop
    try app.run(text_display.widget(), .{});
}
