const std = @import("std");

// Note:
// - I still do not understand Name resolution.

// Verification:
// $ zig test data-structures/linked-list-stack.zig
// All 6 tests passed.

pub fn LinkedListStack(comptime T: type) type {
    return struct {
        pub const Node = struct {
            item: T,
            next: ?*Node,
        };

        head: ?*Node,
        allocator: std.mem.Allocator,

        pub fn init(allocator: std.mem.Allocator) @This() {
            return .{ .head = null, .allocator = allocator };
        }

        pub fn push(self: *@This(), item: T) !void {
            const node = try self.allocator.create(Node);
            node.item = item;
            node.next = self.head;
            self.head = node;
        }

        pub fn pop(self: *@This()) ?T {
            const head_node = self.head orelse return null;
            const item = head_node.item;
            const next = head_node.next;
            self.allocator.destroy(head_node);
            self.head = next;
            return item;
        }

        pub fn deinit(self: *@This()) void {
            while (self.head) |node| {
                self.head = node.next;
                self.allocator.destroy(node);
            }
        }
    };
}

test "push and pop a single integer" {
    const allocator = std.testing.allocator;
    const IntStack = LinkedListStack(u32);
    var stack = IntStack.init(allocator);
    defer stack.deinit();

    try stack.push(10);
    try std.testing.expect(stack.head != null);

    const item = stack.pop();
    try std.testing.expectEqual(item.?, 10);
    try std.testing.expect(stack.head == null);
}

test "push and pop multiple integers" {
    const allocator = std.testing.allocator;
    const IntStack = LinkedListStack(u32);
    var stack = IntStack.init(allocator);
    defer stack.deinit();

    try stack.push(1);
    try stack.push(2);
    try stack.push(3);

    var item = stack.pop();
    try std.testing.expectEqual(item.?, 3);

    item = stack.pop();
    try std.testing.expectEqual(item.?, 2);

    item = stack.pop();
    try std.testing.expectEqual(item.?, 1);
}

test "pop from an empty stack returns null" {
    const allocator = std.testing.allocator;
    const IntStack = LinkedListStack(u32);
    var stack = IntStack.init(allocator);
    defer stack.deinit();

    const item = stack.pop();
    try std.testing.expect(item == null);
}

test "deinit correctly clears the stack" {
    const allocator = std.testing.allocator;
    const IntStack = LinkedListStack(u32);
    var stack = IntStack.init(allocator);
    defer stack.deinit();

    try stack.push(1);
    try stack.push(2);
    try stack.push(3);

    stack.deinit();
    try std.testing.expect(stack.head == null);

    const item = stack.pop();
    try std.testing.expect(item == null);
}

test "stack works with different types (floats)" {
    const allocator = std.testing.allocator;
    const FloatStack = LinkedListStack(f32);
    var stack = FloatStack.init(allocator);
    defer stack.deinit();

    try stack.push(1.5);
    try stack.push(3.0);
    try stack.push(7.2);

    const item1 = stack.pop();
    try std.testing.expectEqual(item1.?, 7.2);

    const item2 = stack.pop();
    try std.testing.expectEqual(item2.?, 3.0);
}

test "stack works with different types (booleans)" {
    const allocator = std.testing.allocator;
    const BoolStack = LinkedListStack(bool);
    var stack = BoolStack.init(allocator);
    defer stack.deinit();

    try stack.push(false);
    try stack.push(true);

    const item1 = stack.pop();
    try std.testing.expectEqual(item1.?, true);

    const item2 = stack.pop();
    try std.testing.expectEqual(item2.?, false);
}
