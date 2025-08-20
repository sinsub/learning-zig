const std = @import("std");
const ImportedRectangleStruct = @import("Rectangle.zig");

// Note:
// - Files are structs.

// Verification:
// $ zig run files/main.zig
// Imported Rectangle: Rectangle{ .width = 1, .height = 2 }
// Local Circle: main.Circle{ .radius = 10 }

pub fn main() void {
    const rect_instance = ImportedRectangleStruct{ .width = 1, .height = 2 };
    const circle_instance = Circle{ .radius = 10 };
    std.debug.print("Imported Rectangle: {}\n", .{rect_instance});
    std.debug.print("Local Circle: {}\n", .{circle_instance});
}

const Circle = struct {
    radius: u32,
};
