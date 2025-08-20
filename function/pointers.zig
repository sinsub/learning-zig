const std = @import("std");

// Note:
// - Pointers include type information.
// - Cannot get pointer to a comptime "object".

// Verification:
// $ zig run function/pointers.zig
// inc: fn (u32) u32@10de420
// inc_bare(1): 2
// inc_ptr(1): 2

fn inc(x: u32) u32 {
    return x + 1;
}

pub fn main() !void {
    std.debug.print("inc: {p}\n", .{&inc});

    // I don't really understand the difference between the following

    // not a copy, a bare function type, zig handles invoking or something
    const inc_bare = inc;
    std.debug.print("inc_bare(1): {d}\n", .{inc_bare(1)});

    // an explicit pointer type
    const inc_ptr = &inc;
    std.debug.print("inc_ptr(1): {d}\n", .{inc_ptr(1)});

    // Zig explicitly implements the function call operator () for both
    // bare function types and function pointer types

    // error: comptime-only type 'fn (comptime type, u32) u32' has no pointer address
    // std.debug.print("comptimeIncOrDec: {p}\n", .{&comptimeIncOrDec});
}
