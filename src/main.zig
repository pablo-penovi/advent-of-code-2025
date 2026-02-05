const std = @import("std");
const aoc2026 = @import("aoc2026");

const ParseArgsError = error{
    MissingDay,
    MissingInput,
    InvalidDay,
    InvalidInput,
    DayOutOfRange,
    InputOutOfRange,
    UnknownFlag,
    FlagWithoutValue,
};

const ParsedArgs = struct {
    day: u8,
    input: u8,
};

fn printUsage() void {
    std.debug.print("Usage: aoc2026 --day <1-31> --input <1-31>\n", .{});
    std.debug.print("Both parameters are required positive integers (1-31)\n", .{});
}

fn parseArgs(args: []const []const u8) ParseArgsError!ParsedArgs {
    var day: ?u8 = null;
    var input: ?u8 = null;

    var i: usize = 1;
    while (i < args.len) : (i += 1) {
        if (std.mem.eql(u8, args[i], "--day")) {
            i += 1;
            if (i >= args.len) return error.FlagWithoutValue;
            day = std.fmt.parseInt(u8, args[i], 10) catch |err| switch (err) {
                error.InvalidCharacter => return error.InvalidDay,
                error.Overflow => return error.InvalidDay,
            };
        } else if (std.mem.eql(u8, args[i], "--input")) {
            i += 1;
            if (i >= args.len) return error.FlagWithoutValue;
            input = std.fmt.parseInt(u8, args[i], 10) catch |err| switch (err) {
                error.InvalidCharacter => return error.InvalidInput,
                error.Overflow => return error.InvalidInput,
            };
        } else {
            return error.UnknownFlag;
        }
    }

    if (day == null) return error.MissingDay;
    if (input == null) return error.MissingInput;

    const day_val = day.?;
    const input_val = input.?;

    if (day_val < 1 or day_val > 31) return error.DayOutOfRange;
    if (input_val < 1 or input_val > 31) return error.InputOutOfRange;

    return ParsedArgs{ .day = day_val, .input = input_val };
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const parsed_args = parseArgs(args) catch |err| {
        switch (err) {
            error.MissingDay => {
                std.debug.print("Error: Missing required parameter: --day\n", .{});
                printUsage();
            },
            error.MissingInput => {
                std.debug.print("Error: Missing required parameter: --input\n", .{});
                printUsage();
            },
            error.InvalidDay => {
                std.debug.print("Error: --day must be a valid positive integer\n", .{});
                printUsage();
            },
            error.InvalidInput => {
                std.debug.print("Error: --input must be a valid positive integer\n", .{});
                printUsage();
            },
            error.DayOutOfRange => {
                std.debug.print("Error: --day must be between 1 and 31\n", .{});
                printUsage();
            },
            error.InputOutOfRange => {
                std.debug.print("Error: --input must be between 1 and 31\n", .{});
                printUsage();
            },
            error.UnknownFlag => {
                std.debug.print("Error: Unknown flag\n", .{});
                printUsage();
            },
            error.FlagWithoutValue => {
                std.debug.print("Error: Flag requires a value\n", .{});
                printUsage();
            },
        }
        return;
    };

    // Success - print the parsed values
    std.debug.print("Day: {}, Input: {}\n", .{ parsed_args.day, parsed_args.input });
    try aoc2026.bufferedPrint();
}

// ===== Command Line Argument Tests =====

test "parseArgs valid input" {
    const args = [_][]const u8{ "program", "--day", "5", "--input", "10" };
    const result = try parseArgs(args[0..]);
    try std.testing.expectEqual(@as(u8, 5), result.day);
    try std.testing.expectEqual(@as(u8, 10), result.input);
}

test "parseArgs valid input boundary values" {
    const args1 = [_][]const u8{ "program", "--day", "1", "--input", "31" };
    const result1 = try parseArgs(args1[0..]);
    try std.testing.expectEqual(@as(u8, 1), result1.day);
    try std.testing.expectEqual(@as(u8, 31), result1.input);

    const args2 = [_][]const u8{ "program", "--day", "31", "--input", "1" };
    const result2 = try parseArgs(args2[0..]);
    try std.testing.expectEqual(@as(u8, 31), result2.day);
    try std.testing.expectEqual(@as(u8, 1), result2.input);
}

test "parseArgs valid input reversed order" {
    const args = [_][]const u8{ "program", "--input", "15", "--day", "8" };
    const result = try parseArgs(args[0..]);
    try std.testing.expectEqual(@as(u8, 8), result.day);
    try std.testing.expectEqual(@as(u8, 15), result.input);
}

test "parseArgs missing day parameter" {
    const args = [_][]const u8{ "program", "--input", "10" };
    try std.testing.expectError(error.MissingDay, parseArgs(args[0..]));
}

test "parseArgs missing input parameter" {
    const args = [_][]const u8{ "program", "--day", "5" };
    try std.testing.expectError(error.MissingInput, parseArgs(args[0..]));
}

test "parseArgs missing both parameters" {
    const args = [_][]const u8{"program"};
    try std.testing.expectError(error.MissingDay, parseArgs(args[0..]));
}

test "parseArgs invalid day format" {
    const args = [_][]const u8{ "program", "--day", "abc", "--input", "10" };
    try std.testing.expectError(error.InvalidDay, parseArgs(args[0..]));
}

test "parseArgs invalid input format" {
    const args = [_][]const u8{ "program", "--day", "5", "--input", "xyz" };
    try std.testing.expectError(error.InvalidInput, parseArgs(args[0..]));
}

test "parseArgs day out of range too low" {
    const args = [_][]const u8{ "program", "--day", "0", "--input", "10" };
    try std.testing.expectError(error.DayOutOfRange, parseArgs(args[0..]));
}

test "parseArgs day out of range too high" {
    const args = [_][]const u8{ "program", "--day", "32", "--input", "10" };
    try std.testing.expectError(error.DayOutOfRange, parseArgs(args[0..]));
}

test "parseArgs input out of range too low" {
    const args = [_][]const u8{ "program", "--day", "5", "--input", "0" };
    try std.testing.expectError(error.InputOutOfRange, parseArgs(args[0..]));
}

test "parseArgs input out of range too high" {
    const args = [_][]const u8{ "program", "--day", "5", "--input", "32" };
    try std.testing.expectError(error.InputOutOfRange, parseArgs(args[0..]));
}

test "parseArgs unknown flag" {
    const args = [_][]const u8{ "program", "--unknown", "5", "--input", "10" };
    try std.testing.expectError(error.UnknownFlag, parseArgs(args[0..]));
}

test "parseArgs flag without value day" {
    const args = [_][]const u8{ "program", "--day", "--input", "10" };
    try std.testing.expectError(error.InvalidDay, parseArgs(args[0..]));
}

test "parseArgs flag without value input" {
    const args = [_][]const u8{ "program", "--day", "5", "--input" };
    try std.testing.expectError(error.FlagWithoutValue, parseArgs(args[0..]));
}

test "parseArgs flag without value at end" {
    const args = [_][]const u8{ "program", "--day", "5", "--input" };
    try std.testing.expectError(error.FlagWithoutValue, parseArgs(args[0..]));
}

test "parseArgs negative numbers" {
    const args = [_][]const u8{ "program", "--day", "-5", "--input", "10" };
    try std.testing.expectError(error.InvalidDay, parseArgs(args[0..]));
}

test "parseArgs maximum u8 value rejected" {
    const args = [_][]const u8{ "program", "--day", "255", "--input", "10" };
    try std.testing.expectError(error.DayOutOfRange, parseArgs(args[0..]));
}

test "parseArgs empty string values" {
    const args = [_][]const u8{ "program", "--day", "", "--input", "10" };
    try std.testing.expectError(error.InvalidDay, parseArgs(args[0..]));
}

// ===== Original Tests =====

test "simple test" {
    const gpa = std.testing.allocator;
    var list: std.ArrayList(i32) = .empty;
    defer list.deinit(gpa); // Try commenting this out and see if zig detects the memory leak!
    try list.append(gpa, 42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try std.testing.fuzz(Context{}, Context.testOne, .{});
}
