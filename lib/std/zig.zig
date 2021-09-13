const std = @import("std.zig");
const tokenizer = @import("zig/tokenizer.zig");
const fmt = @import("zig/fmt.zig");
const assert = std.debug.assert;

pub const Token = tokenizer.Token;
pub const Tokenizer = tokenizer.Tokenizer;
pub const fmtId = fmt.fmtId;
pub const fmtEscapes = fmt.fmtEscapes;
pub const isValidId = fmt.isValidId;
pub const parse = @import("zig/parse.zig").parse;
pub const string_literal = @import("zig/string_literal.zig");
pub const Ast = @import("zig/Ast.zig");
pub const system = @import("zig/system.zig");
pub const CrossTarget = @import("zig/cross_target.zig").CrossTarget;

// Files needed by translate-c.
pub const c_builtins = @import("zig/c_builtins.zig");
pub const c_translation = @import("zig/c_translation.zig");

pub const SrcHash = [16]u8;

pub fn hashSrc(src: []const u8) SrcHash {
    var out: SrcHash = undefined;
    std.crypto.hash.Blake3.hash(src, &out, .{});
    return out;
}

pub fn srcHashEql(a: SrcHash, b: SrcHash) bool {
    return @bitCast(u128, a) == @bitCast(u128, b);
}

pub fn hashName(parent_hash: SrcHash, sep: []const u8, name: []const u8) SrcHash {
    var out: SrcHash = undefined;
    var hasher = std.crypto.hash.Blake3.init(.{});
    hasher.update(&parent_hash);
    hasher.update(sep);
    hasher.update(name);
    hasher.final(&out);
    return out;
}

pub const Loc = struct {
    line: usize,
    column: usize,
    /// Does not include the trailing newline.
    source_line: []const u8,
};

pub fn findLineColumn(source: []const u8, byte_offset: usize) Loc {
    var line: usize = 0;
    var column: usize = 0;
    var line_start: usize = 0;
    var i: usize = 0;
    while (i < byte_offset) : (i += 1) {
        switch (source[i]) {
            '\n' => {
                line += 1;
                column = 0;
                line_start = i + 1;
            },
            else => {
                column += 1;
            },
        }
    }
    while (i < source.len and source[i] != '\n') {
        i += 1;
    }
    return .{
        .line = line,
        .column = column,
        .source_line = source[line_start..i],
    };
}

pub fn lineDelta(source: []const u8, start: usize, end: usize) isize {
    var line: isize = 0;
    if (end >= start) {
        for (source[start..end]) |byte| switch (byte) {
            '\n' => line += 1,
            else => continue,
        };
    } else {
        for (source[end..start]) |byte| switch (byte) {
            '\n' => line -= 1,
            else => continue,
        };
    }
    return line;
}

pub const BinNameOptions = struct {
    root_name: []const u8,
    target: std.Target,
    output_mode: std.builtin.OutputMode,
    link_mode: ?std.builtin.LinkMode = null,
    object_format: ?std.Target.ObjectFormat = null,
    version: ?std.builtin.Version = null,
};

/// Returns the standard file system basename of a binary generated by the Zig compiler.
pub fn binNameAlloc(allocator: *std.mem.Allocator, options: BinNameOptions) error{OutOfMemory}![]u8 {
    const root_name = options.root_name;
    const target = options.target;
    const ofmt = options.object_format orelse target.getObjectFormat();
    switch (ofmt) {
        .coff => switch (options.output_mode) {
            .Exe => return std.fmt.allocPrint(allocator, "{s}{s}", .{ root_name, target.exeFileExt() }),
            .Lib => {
                const suffix = switch (options.link_mode orelse .Static) {
                    .Static => ".lib",
                    .Dynamic => ".dll",
                };
                return std.fmt.allocPrint(allocator, "{s}{s}", .{ root_name, suffix });
            },
            .Obj => return std.fmt.allocPrint(allocator, "{s}.obj", .{root_name}),
        },
        .elf => switch (options.output_mode) {
            .Exe => return allocator.dupe(u8, root_name),
            .Lib => {
                switch (options.link_mode orelse .Static) {
                    .Static => return std.fmt.allocPrint(allocator, "{s}{s}.a", .{
                        target.libPrefix(), root_name,
                    }),
                    .Dynamic => {
                        if (options.version) |ver| {
                            return std.fmt.allocPrint(allocator, "{s}{s}.so.{d}.{d}.{d}", .{
                                target.libPrefix(), root_name, ver.major, ver.minor, ver.patch,
                            });
                        } else {
                            return std.fmt.allocPrint(allocator, "{s}{s}.so", .{
                                target.libPrefix(), root_name,
                            });
                        }
                    },
                }
            },
            .Obj => return std.fmt.allocPrint(allocator, "{s}.o", .{root_name}),
        },
        .macho => switch (options.output_mode) {
            .Exe => return allocator.dupe(u8, root_name),
            .Lib => {
                switch (options.link_mode orelse .Static) {
                    .Static => return std.fmt.allocPrint(allocator, "{s}{s}.a", .{
                        target.libPrefix(), root_name,
                    }),
                    .Dynamic => {
                        if (options.version) |ver| {
                            return std.fmt.allocPrint(allocator, "{s}{s}.{d}.{d}.{d}.dylib", .{
                                target.libPrefix(), root_name, ver.major, ver.minor, ver.patch,
                            });
                        } else {
                            return std.fmt.allocPrint(allocator, "{s}{s}.dylib", .{
                                target.libPrefix(), root_name,
                            });
                        }
                    },
                }
            },
            .Obj => return std.fmt.allocPrint(allocator, "{s}.o", .{root_name}),
        },
        .wasm => switch (options.output_mode) {
            .Exe => return std.fmt.allocPrint(allocator, "{s}{s}", .{ root_name, target.exeFileExt() }),
            .Lib => {
                switch (options.link_mode orelse .Static) {
                    .Static => return std.fmt.allocPrint(allocator, "{s}{s}.a", .{
                        target.libPrefix(), root_name,
                    }),
                    .Dynamic => return std.fmt.allocPrint(allocator, "{s}.wasm", .{root_name}),
                }
            },
            .Obj => return std.fmt.allocPrint(allocator, "{s}.o", .{root_name}),
        },
        .c => return std.fmt.allocPrint(allocator, "{s}.c", .{root_name}),
        .spirv => return std.fmt.allocPrint(allocator, "{s}.spv", .{root_name}),
        .hex => return std.fmt.allocPrint(allocator, "{s}.ihex", .{root_name}),
        .raw => return std.fmt.allocPrint(allocator, "{s}.bin", .{root_name}),
        .plan9 => switch (options.output_mode) {
            .Exe => return allocator.dupe(u8, root_name),
            .Obj => return std.fmt.allocPrint(allocator, "{s}{s}", .{ root_name, ofmt.fileExt(target.cpu.arch) }),
            .Lib => return std.fmt.allocPrint(allocator, "{s}{s}.a", .{ target.libPrefix(), root_name }),
        },
    }
}

pub const ParsedCharLiteral = union(enum) {
    success: u32,
    /// The character after backslash is not recognized.
    invalid_escape_character: usize,
    /// Expected hex digit at this index.
    expected_hex_digit: usize,
    /// Unicode escape sequence had no digits with rbrace at this index.
    empty_unicode_escape_sequence: usize,
    /// Expected hex digit or '}' at this index.
    expected_hex_digit_or_rbrace: usize,
    /// The unicode point is outside the range of Unicode codepoints.
    unicode_escape_overflow: usize,
    /// Expected '{' at this index.
    expected_lbrace: usize,
    /// Expected the terminating single quote at this index.
    expected_end: usize,
    /// The character at this index cannot be represented without an escape sequence.
    invalid_character: usize,
};

/// Only validates escape sequence characters.
/// Slice must be valid utf8 starting and ending with "'" and exactly one codepoint in between.
pub fn parseCharLiteral(slice: []const u8) ParsedCharLiteral {
    assert(slice.len >= 3 and slice[0] == '\'' and slice[slice.len - 1] == '\'');

    switch (slice[1]) {
        0 => return .{ .invalid_character = 1 },
        '\\' => switch (slice[2]) {
            'n' => return .{ .success = '\n' },
            'r' => return .{ .success = '\r' },
            '\\' => return .{ .success = '\\' },
            't' => return .{ .success = '\t' },
            '\'' => return .{ .success = '\'' },
            '"' => return .{ .success = '"' },
            'x' => {
                if (slice.len < 4) {
                    return .{ .expected_hex_digit = 3 };
                }
                var value: u32 = 0;
                var i: usize = 3;
                while (i < 5) : (i += 1) {
                    const c = slice[i];
                    switch (c) {
                        '0'...'9' => {
                            value *= 16;
                            value += c - '0';
                        },
                        'a'...'f' => {
                            value *= 16;
                            value += c - 'a' + 10;
                        },
                        'A'...'F' => {
                            value *= 16;
                            value += c - 'A' + 10;
                        },
                        else => {
                            return .{ .expected_hex_digit = i };
                        },
                    }
                }
                if (slice[i] != '\'') {
                    return .{ .expected_end = i };
                }
                return .{ .success = value };
            },
            'u' => {
                var i: usize = 3;
                if (slice[i] != '{') {
                    return .{ .expected_lbrace = i };
                }
                i += 1;
                if (slice[i] == '}') {
                    return .{ .empty_unicode_escape_sequence = i };
                }

                var value: u32 = 0;
                while (i < slice.len) : (i += 1) {
                    const c = slice[i];
                    switch (c) {
                        '0'...'9' => {
                            value *= 16;
                            value += c - '0';
                        },
                        'a'...'f' => {
                            value *= 16;
                            value += c - 'a' + 10;
                        },
                        'A'...'F' => {
                            value *= 16;
                            value += c - 'A' + 10;
                        },
                        '}' => {
                            i += 1;
                            break;
                        },
                        else => return .{ .expected_hex_digit_or_rbrace = i },
                    }
                    if (value > 0x10ffff) {
                        return .{ .unicode_escape_overflow = i };
                    }
                }
                if (slice[i] != '\'') {
                    return .{ .expected_end = i };
                }
                return .{ .success = value };
            },
            else => return .{ .invalid_escape_character = 2 },
        },
        else => {
            const codepoint = std.unicode.utf8Decode(slice[1 .. slice.len - 1]) catch unreachable;
            return .{ .success = codepoint };
        },
    }
}

test "parseCharLiteral" {
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 'a' },
        parseCharLiteral("'a'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 'ä' },
        parseCharLiteral("'ä'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 0 },
        parseCharLiteral("'\\x00'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 0x4f },
        parseCharLiteral("'\\x4f'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 0x4f },
        parseCharLiteral("'\\x4F'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 0x3041 },
        parseCharLiteral("'ぁ'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 0 },
        parseCharLiteral("'\\u{0}'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 0x3041 },
        parseCharLiteral("'\\u{3041}'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 0x7f },
        parseCharLiteral("'\\u{7f}'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .success = 0x7fff },
        parseCharLiteral("'\\u{7FFF}'"),
    );

    try std.testing.expectEqual(
        ParsedCharLiteral{ .expected_hex_digit = 4 },
        parseCharLiteral("'\\x0'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .expected_end = 5 },
        parseCharLiteral("'\\x000'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .invalid_escape_character = 2 },
        parseCharLiteral("'\\y'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .expected_lbrace = 3 },
        parseCharLiteral("'\\u'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .expected_lbrace = 3 },
        parseCharLiteral("'\\uFFFF'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .empty_unicode_escape_sequence = 4 },
        parseCharLiteral("'\\u{}'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .unicode_escape_overflow = 9 },
        parseCharLiteral("'\\u{FFFFFF}'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .expected_hex_digit_or_rbrace = 8 },
        parseCharLiteral("'\\u{FFFF'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .expected_end = 9 },
        parseCharLiteral("'\\u{FFFF}x'"),
    );
    try std.testing.expectEqual(
        ParsedCharLiteral{ .invalid_character = 1 },
        parseCharLiteral("'\x00'"),
    );
}

test {
    @import("std").testing.refAllDecls(@This());
}
