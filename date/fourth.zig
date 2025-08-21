//! fourth.zig - used at all times

fn factorial(n: u32) u32 {
    if (n <= 2) return n;
    return n * factorial(n - 1);
}

pub fn main() void {
    print(comptime factorial(5));
    print(factorial(5));
}

pub fn print(value: anytype) void {
    const std = @import("std");
    std.debug.print("{}\n", .{value});
}
