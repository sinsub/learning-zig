//! second.zig - simple factorial

pub fn factorial(n: u32) u32 {
    if (n <= 1) return n;
    return n * factorial(n - 1);
}

pub fn main() void {
    _ = factorial(10000);
}
