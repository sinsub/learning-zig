//! first.zig - comptime parameter

const std = @import("std");

pub fn negate(comptime T: type, value: T) T {
    const type_info = @typeInfo(T);
    switch (type_info) {
        .bool => return !value,
        .int, .float => return -value,
        else => @compileError("Type not supported!"),
    }
}

pub fn main() void {
    std.debug.print("{}\n", .{negate(i32, 5)});
    std.debug.print("{}\n", .{negate(bool, true)});
    // _ = negate([2]u8, .{ 'H', 'i' }); // array - unsupported type
}
