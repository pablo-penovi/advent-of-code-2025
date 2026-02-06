pub const packages = struct {
    pub const @"uucode-0.1.0-ZZjBPj96QADXyt5sqwBJUnhaDYs_qBeeKijZvlRa0eqM" = struct {
        pub const build_root = "/home/pablo/.cache/zig/p/uucode-0.1.0-ZZjBPj96QADXyt5sqwBJUnhaDYs_qBeeKijZvlRa0eqM";
        pub const build_zig = @import("uucode-0.1.0-ZZjBPj96QADXyt5sqwBJUnhaDYs_qBeeKijZvlRa0eqM");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"vaxis-0.5.1-BWNV_Bw_CQAIVNh1ekGVzbip25CYBQ_J3kgABnYGFnI4" = struct {
        pub const build_root = "/home/pablo/.cache/zig/p/vaxis-0.5.1-BWNV_Bw_CQAIVNh1ekGVzbip25CYBQ_J3kgABnYGFnI4";
        pub const build_zig = @import("vaxis-0.5.1-BWNV_Bw_CQAIVNh1ekGVzbip25CYBQ_J3kgABnYGFnI4");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "zigimg", "zigimg-0.1.0-8_eo2vUZFgAAtN1c6dAO5DdqL0d4cEWHtn6iR5ucZJti" },
            .{ "uucode", "uucode-0.1.0-ZZjBPj96QADXyt5sqwBJUnhaDYs_qBeeKijZvlRa0eqM" },
        };
    };
    pub const @"zigimg-0.1.0-8_eo2vUZFgAAtN1c6dAO5DdqL0d4cEWHtn6iR5ucZJti" = struct {
        pub const build_root = "/home/pablo/.cache/zig/p/zigimg-0.1.0-8_eo2vUZFgAAtN1c6dAO5DdqL0d4cEWHtn6iR5ucZJti";
        pub const build_zig = @import("zigimg-0.1.0-8_eo2vUZFgAAtN1c6dAO5DdqL0d4cEWHtn6iR5ucZJti");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "vaxis", "vaxis-0.5.1-BWNV_Bw_CQAIVNh1ekGVzbip25CYBQ_J3kgABnYGFnI4" },
};
