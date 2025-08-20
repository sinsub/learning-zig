const std = @import("std");

// Note:
// - If a function has comptime parameters, multiple instances of
//   the function will be created at compile time, based on the parameter
// - Beware. A few lines can generate a lot of code!

// Verification:
// $ zig build-obj function/bloated-comptime.zig
//
// $ nm -a bloated-comptime.o | grep fib
// 000000000009dc60 t bloated-comptime.fib__anon_23921
// 000000000009ec40 t bloated-comptime.fib__anon_24039
// 000000000009ee50 t bloated-comptime.fib__anon_24138
// <lines omitted>
//
// $ nm -a bloated-comptime.o | grep fib | wc -l
// 1000

fn fib(comptime n: u32) u32 {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 1);
}

pub fn main() !void {
    std.debug.print("fib(1000): {}\n", .{fib(1000)});
}
