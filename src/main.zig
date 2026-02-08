const std = @import("std");
const vaxis = @import("vaxis");
const vxfw = vaxis.vxfw;

/// Our day selector application state
const DaySelector = struct {
    /// The list view showing days 1-25
    list_view: vxfw.ListView,
    /// Selected day (0-24, corresponding to days 1-25)
    selected_day: u8 = 0,
    /// Whether we should exit
    should_exit: bool = false,

    pub fn init(allocator: std.mem.Allocator) !*DaySelector {
        const self = try allocator.create(DaySelector);

        // Create day widgets (1-25)
        var day_widgets = try allocator.alloc(vxfw.Widget, 25);
        for (1..26) |day| {
            const day_text = try std.fmt.allocPrint(allocator, "Day {d}", .{day});
            const text_widget: vxfw.Text = .{ .text = day_text };
            day_widgets[day - 1] = text_widget.widget();
        }

        self.* = .{
            .list_view = .{
                .children = .{ .slice = day_widgets },
                .draw_cursor = true,
                .wheel_scroll = 3,
            },
            .selected_day = 0,
            .should_exit = false,
        };

        return self;
    }

    /// Helper function to return a vxfw.Widget struct
    pub fn widget(self: *DaySelector) vxfw.Widget {
        return .{
            .userdata = self,
            .eventHandler = typeErasedEventHandler,
            .drawFn = typeErasedDrawFn,
        };
    }

    /// This function will be called from the vxfw runtime.
    fn typeErasedEventHandler(ptr: *anyopaque, ctx: *vxfw.EventContext, event: vxfw.Event) anyerror!void {
        const self: *DaySelector = @ptrCast(@alignCast(ptr));
        switch (event) {
            // The root widget is always sent an init event as the first event
            .init => return ctx.requestFocus(self.list_view.widget()),
            .key_press => |key| {
                if (key.matches('c', .{ .ctrl = true }) or key.matches('q', .{})) {
                    ctx.quit = true;
                    return;
                }
                if (key.matches(vaxis.Key.enter, .{})) {
                    self.selected_day = @intCast(self.list_view.cursor);
                    self.should_exit = true;
                    // TODO: Output selected day - for now just exit
                    ctx.quit = true;
                    return ctx.consumeAndRedraw();
                }
                return self.list_view.handleEvent(ctx, event);
            },
            // We can request a specific widget gets focus. In this case, we always want to focus
            // our list view
            .focus_in => return ctx.requestFocus(self.list_view.widget()),
            else => return self.list_view.handleEvent(ctx, event),
        }
    }

    /// This function is called from the vxfw runtime. It will be called on a regular interval, and
    /// only when any event handler has marked the redraw flag in EventContext as true. By
    /// explicitly requiring setting the redraw flag, vxfw can prevent excessive redraws for events
    /// which don't change state (ie mouse motion, unhandled key events, etc)
    fn typeErasedDrawFn(ptr: *anyopaque, ctx: vxfw.DrawContext) std.mem.Allocator.Error!vxfw.Surface {
        const self: *DaySelector = @ptrCast(@alignCast(ptr));
        // The DrawContext is inspired from Flutter. Each widget will receive a minimum and maximum
        // constraint. The minimum constraint will always be set, even if it is set to 0x0. The
        // maximum constraint can have null width and/or height - meaning there is no constraint in
        // that direction and the widget should take up as much space as it needs. By calling size()
        // on the max, we assert that it has some constrained size. This is *always* the case for
        // the root widget - the maximum size will always be the size of the terminal screen.
        const max_size = ctx.max.size();

        // Create title text
        const title: vxfw.Text = .{ .text = "Select Advent of Code Day:", .style = .{ .bold = true } };

        // Each widget returns a Surface from its draw function. A Surface contains the rectangular
        // area of the widget, as well as some information about the surface or widget: can we focus
        // it? does it handle the mouse?
        //
        // It DOES NOT contain the location it should be within its parent. Only the parent can set
        // this via a SubSurface. Here, we will return a Surface for the root widget (DaySelector), which
        // has two SubSurfaces: one for the title and one for the list view. A SubSurface is a Surface
        // with an offset and a z-index - the offset can be negative. This lets a parent draw a
        // child and place it within itself
        const title_child: vxfw.SubSurface = .{
            .origin = .{ .row = 0, .col = 0 },
            .surface = try title.draw(ctx),
        };

        const list_child: vxfw.SubSurface = .{
            .origin = .{ .row = 2, .col = 2 },
            .surface = try self.list_view.draw(ctx.withConstraints(
                ctx.min,
                // Give the list view most of the available space
                .{ .width = max_size.width - 4, .height = max_size.height - 4 },
            )),
        };

        // We also can use our arena to allocate the slice for our SubSurfaces. This slice only
        // needs to live until the next frame, making this safe.
        const children = try ctx.arena.alloc(vxfw.SubSurface, 2);
        children[0] = title_child;
        children[1] = list_child;

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
    const allocator = std.heap.page_allocator;

    // Try TUI version first, fallback to console if TTY not available
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) {
            std.log.err("memory leak", .{});
        }
    }
    const gpa_allocator = gpa.allocator();

    var app = vxfw.App.init(gpa_allocator) catch |err| switch (err) {
        error.Unexpected => {
            // Fallback to console if TTY not available
            return runConsoleFallback(allocator);
        },
        else => return err,
    };
    defer app.deinit();

    // Create the day selector
    var day_selector = try DaySelector.init(gpa_allocator);
    defer gpa_allocator.destroy(day_selector);

    // Main event loop
    try app.run(day_selector.widget(), .{});
}

fn runConsoleFallback(_: std.mem.Allocator) !void {
    // Simple console fallback
    std.debug.print("Select Advent of Code Day:\n", .{});
    for (1..26) |day| {
        std.debug.print("  {}\n", .{day});
    }
    std.debug.print("\n(TTY not available - using console fallback)\n", .{});
    std.debug.print("In a real terminal, you would see an interactive TUI day selector.\n", .{});
}
