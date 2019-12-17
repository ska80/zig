const feature = @import("std").target.feature;
const CpuInfo = @import("std").target.cpu.CpuInfo;

pub const AmdGpuCpu = enum {
    Bonaire,
    Carrizo,
    Fiji,
    Generic,
    GenericHsa,
    Gfx1010,
    Gfx1011,
    Gfx1012,
    Gfx600,
    Gfx601,
    Gfx700,
    Gfx701,
    Gfx702,
    Gfx703,
    Gfx704,
    Gfx801,
    Gfx802,
    Gfx803,
    Gfx810,
    Gfx900,
    Gfx902,
    Gfx904,
    Gfx906,
    Gfx908,
    Gfx909,
    Hainan,
    Hawaii,
    Iceland,
    Kabini,
    Kaveri,
    Mullins,
    Oland,
    Pitcairn,
    Polaris10,
    Polaris11,
    Stoney,
    Tahiti,
    Tonga,
    Verde,

    const FeatureType = feature.AmdGpuFeature;

    pub fn getInfo(self: @This()) CpuInfo(@This(), FeatureType) {
        return cpu_infos[@enumToInt(self)];
    }

    pub const cpu_infos = [@memberCount(@This())]CpuInfo(@This(), FeatureType) {
        CpuInfo(@This(), FeatureType).create(.Bonaire, "bonaire", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Carrizo, "carrizo", &[_]FeatureType {
            .CodeObjectV3,
            .FastFmaf,
            .Ldsbankcount32,
            .UnpackedD16Vmem,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
            .Xnack,
            .HalfRate64Ops,
        }),
        CpuInfo(@This(), FeatureType).create(.Fiji, "fiji", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .UnpackedD16Vmem,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Generic, "generic", &[_]FeatureType {
            .Wavefrontsize64,
        }),
        CpuInfo(@This(), FeatureType).create(.GenericHsa, "generic-hsa", &[_]FeatureType {
            .FlatAddressSpace,
            .Wavefrontsize64,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx1010, "gfx1010", &[_]FeatureType {
            .CodeObjectV3,
            .DlInsts,
            .NoXnackSupport,
            .FlatSegmentOffsetBug,
            .Vscnt,
            .ApertureRegs,
            .Gfx10Insts,
            .IntClampInsts,
            .PkFmacF16Inst,
            .SdwaOmod,
            .SdwaScalar,
            .AddNoCarryInsts,
            .Movrel,
            .SMemrealtime,
            .NoSdstCmpx,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .NoSramEccSupport,
            .SdwaSdst,
            .FlatInstOffsets,
            .RegisterBanking,
            .Dpp,
            .Localmemorysize65536,
            .Vop3p,
            .BitInsts16,
            .Dpp8,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .Gfx9Insts,
            .FmaMixInsts,
            .MimgR128,
            .Vop3Literal,
            .FlatGlobalInsts,
            .FlatScratchInsts,
            .Fp64,
            .FastFmaf,
            .NoDataDepHazard,
            .Gfx10,
            .InstFwdPrefetchBug,
            .Ldsbankcount32,
            .LdsBranchVmemWarHazard,
            .LdsMisalignedBug,
            .NsaEncoding,
            .NsaToVmemBug,
            .Offset3fBug,
            .SmemToVectorWriteHazard,
            .ScalarAtomics,
            .ScalarFlatScratchInsts,
            .ScalarStores,
            .VmemToScalarWriteHazard,
            .VcmpxExecWarHazard,
            .VcmpxPermlaneHazard,
            .Wavefrontsize32,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx1011, "gfx1011", &[_]FeatureType {
            .CodeObjectV3,
            .DlInsts,
            .NoXnackSupport,
            .Dot1Insts,
            .Dot2Insts,
            .Dot5Insts,
            .Dot6Insts,
            .FlatSegmentOffsetBug,
            .Vscnt,
            .ApertureRegs,
            .Gfx10Insts,
            .IntClampInsts,
            .PkFmacF16Inst,
            .SdwaOmod,
            .SdwaScalar,
            .AddNoCarryInsts,
            .Movrel,
            .SMemrealtime,
            .NoSdstCmpx,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .NoSramEccSupport,
            .SdwaSdst,
            .FlatInstOffsets,
            .RegisterBanking,
            .Dpp,
            .Localmemorysize65536,
            .Vop3p,
            .BitInsts16,
            .Dpp8,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .Gfx9Insts,
            .FmaMixInsts,
            .MimgR128,
            .Vop3Literal,
            .FlatGlobalInsts,
            .FlatScratchInsts,
            .Fp64,
            .FastFmaf,
            .NoDataDepHazard,
            .Gfx10,
            .InstFwdPrefetchBug,
            .Ldsbankcount32,
            .LdsBranchVmemWarHazard,
            .NsaEncoding,
            .NsaToVmemBug,
            .Offset3fBug,
            .SmemToVectorWriteHazard,
            .ScalarAtomics,
            .ScalarFlatScratchInsts,
            .ScalarStores,
            .VmemToScalarWriteHazard,
            .VcmpxExecWarHazard,
            .VcmpxPermlaneHazard,
            .Wavefrontsize32,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx1012, "gfx1012", &[_]FeatureType {
            .CodeObjectV3,
            .DlInsts,
            .NoXnackSupport,
            .Dot1Insts,
            .Dot2Insts,
            .Dot5Insts,
            .Dot6Insts,
            .FlatSegmentOffsetBug,
            .Vscnt,
            .ApertureRegs,
            .Gfx10Insts,
            .IntClampInsts,
            .PkFmacF16Inst,
            .SdwaOmod,
            .SdwaScalar,
            .AddNoCarryInsts,
            .Movrel,
            .SMemrealtime,
            .NoSdstCmpx,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .NoSramEccSupport,
            .SdwaSdst,
            .FlatInstOffsets,
            .RegisterBanking,
            .Dpp,
            .Localmemorysize65536,
            .Vop3p,
            .BitInsts16,
            .Dpp8,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .Gfx9Insts,
            .FmaMixInsts,
            .MimgR128,
            .Vop3Literal,
            .FlatGlobalInsts,
            .FlatScratchInsts,
            .Fp64,
            .FastFmaf,
            .NoDataDepHazard,
            .Gfx10,
            .InstFwdPrefetchBug,
            .Ldsbankcount32,
            .LdsBranchVmemWarHazard,
            .LdsMisalignedBug,
            .NsaEncoding,
            .NsaToVmemBug,
            .Offset3fBug,
            .SmemToVectorWriteHazard,
            .ScalarAtomics,
            .ScalarFlatScratchInsts,
            .ScalarStores,
            .VmemToScalarWriteHazard,
            .VcmpxExecWarHazard,
            .VcmpxPermlaneHazard,
            .Wavefrontsize32,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx600, "gfx600", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .FastFmaf,
            .Ldsbankcount32,
            .Movrel,
            .MimgR128,
            .Fp64,
            .TrigReducedRange,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .Localmemorysize32768,
            .SouthernIslands,
            .HalfRate64Ops,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx601, "gfx601", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .Movrel,
            .MimgR128,
            .Fp64,
            .TrigReducedRange,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .Localmemorysize32768,
            .SouthernIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx700, "gfx700", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx701, "gfx701", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .FastFmaf,
            .Ldsbankcount32,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
            .HalfRate64Ops,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx702, "gfx702", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .FastFmaf,
            .Ldsbankcount16,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx703, "gfx703", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount16,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx704, "gfx704", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx801, "gfx801", &[_]FeatureType {
            .CodeObjectV3,
            .FastFmaf,
            .Ldsbankcount32,
            .UnpackedD16Vmem,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
            .Xnack,
            .HalfRate64Ops,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx802, "gfx802", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .SgprInitBug,
            .UnpackedD16Vmem,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx803, "gfx803", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .UnpackedD16Vmem,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx810, "gfx810", &[_]FeatureType {
            .CodeObjectV3,
            .Ldsbankcount16,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
            .Xnack,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx900, "gfx900", &[_]FeatureType {
            .CodeObjectV3,
            .NoSramEccSupport,
            .NoXnackSupport,
            .ApertureRegs,
            .IntClampInsts,
            .SdwaOmod,
            .SdwaScalar,
            .AddNoCarryInsts,
            .ScalarAtomics,
            .SMemrealtime,
            .Gcn3Encoding,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .SdwaSdst,
            .FlatInstOffsets,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .R128A16,
            .Dpp,
            .Localmemorysize65536,
            .Vop3p,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .Gfx9Insts,
            .ScalarFlatScratchInsts,
            .FlatGlobalInsts,
            .FlatScratchInsts,
            .Fp64,
            .FastFmaf,
            .Gfx9,
            .Ldsbankcount32,
            .MadMixInsts,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx902, "gfx902", &[_]FeatureType {
            .CodeObjectV3,
            .NoSramEccSupport,
            .ApertureRegs,
            .IntClampInsts,
            .SdwaOmod,
            .SdwaScalar,
            .AddNoCarryInsts,
            .ScalarAtomics,
            .SMemrealtime,
            .Gcn3Encoding,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .SdwaSdst,
            .FlatInstOffsets,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .R128A16,
            .Dpp,
            .Localmemorysize65536,
            .Vop3p,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .Gfx9Insts,
            .ScalarFlatScratchInsts,
            .FlatGlobalInsts,
            .FlatScratchInsts,
            .Fp64,
            .FastFmaf,
            .Gfx9,
            .Ldsbankcount32,
            .MadMixInsts,
            .Xnack,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx904, "gfx904", &[_]FeatureType {
            .CodeObjectV3,
            .NoSramEccSupport,
            .NoXnackSupport,
            .FmaMixInsts,
            .ApertureRegs,
            .IntClampInsts,
            .SdwaOmod,
            .SdwaScalar,
            .AddNoCarryInsts,
            .ScalarAtomics,
            .SMemrealtime,
            .Gcn3Encoding,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .SdwaSdst,
            .FlatInstOffsets,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .R128A16,
            .Dpp,
            .Localmemorysize65536,
            .Vop3p,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .Gfx9Insts,
            .ScalarFlatScratchInsts,
            .FlatGlobalInsts,
            .FlatScratchInsts,
            .Fp64,
            .FastFmaf,
            .Gfx9,
            .Ldsbankcount32,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx906, "gfx906", &[_]FeatureType {
            .CodeObjectV3,
            .DlInsts,
            .NoXnackSupport,
            .Dot1Insts,
            .Dot2Insts,
            .FmaMixInsts,
            .ApertureRegs,
            .IntClampInsts,
            .SdwaOmod,
            .SdwaScalar,
            .AddNoCarryInsts,
            .ScalarAtomics,
            .SMemrealtime,
            .Gcn3Encoding,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .SdwaSdst,
            .FlatInstOffsets,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .R128A16,
            .Dpp,
            .Localmemorysize65536,
            .Vop3p,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .Gfx9Insts,
            .ScalarFlatScratchInsts,
            .FlatGlobalInsts,
            .FlatScratchInsts,
            .Fp64,
            .FastFmaf,
            .Gfx9,
            .Ldsbankcount32,
            .HalfRate64Ops,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx908, "gfx908", &[_]FeatureType {
            .AtomicFaddInsts,
            .CodeObjectV3,
            .DlInsts,
            .Dot1Insts,
            .Dot2Insts,
            .Dot3Insts,
            .Dot4Insts,
            .Dot5Insts,
            .Dot6Insts,
            .FmaMixInsts,
            .ApertureRegs,
            .IntClampInsts,
            .SdwaOmod,
            .SdwaScalar,
            .AddNoCarryInsts,
            .ScalarAtomics,
            .SMemrealtime,
            .Gcn3Encoding,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .SdwaSdst,
            .FlatInstOffsets,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .R128A16,
            .Dpp,
            .Localmemorysize65536,
            .Vop3p,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .Gfx9Insts,
            .ScalarFlatScratchInsts,
            .FlatGlobalInsts,
            .FlatScratchInsts,
            .Fp64,
            .FastFmaf,
            .Gfx9,
            .Ldsbankcount32,
            .MaiInsts,
            .MfmaInlineLiteralBug,
            .PkFmacF16Inst,
            .SramEcc,
            .HalfRate64Ops,
        }),
        CpuInfo(@This(), FeatureType).create(.Gfx909, "gfx909", &[_]FeatureType {
            .CodeObjectV3,
            .ApertureRegs,
            .IntClampInsts,
            .SdwaOmod,
            .SdwaScalar,
            .AddNoCarryInsts,
            .ScalarAtomics,
            .SMemrealtime,
            .Gcn3Encoding,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .SdwaSdst,
            .FlatInstOffsets,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .R128A16,
            .Dpp,
            .Localmemorysize65536,
            .Vop3p,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .Gfx9Insts,
            .ScalarFlatScratchInsts,
            .FlatGlobalInsts,
            .FlatScratchInsts,
            .Fp64,
            .FastFmaf,
            .Gfx9,
            .Ldsbankcount32,
            .MadMixInsts,
            .Xnack,
        }),
        CpuInfo(@This(), FeatureType).create(.Hainan, "hainan", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .Movrel,
            .MimgR128,
            .Fp64,
            .TrigReducedRange,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .Localmemorysize32768,
            .SouthernIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Hawaii, "hawaii", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .FastFmaf,
            .Ldsbankcount32,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
            .HalfRate64Ops,
        }),
        CpuInfo(@This(), FeatureType).create(.Iceland, "iceland", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .SgprInitBug,
            .UnpackedD16Vmem,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Kabini, "kabini", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount16,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Kaveri, "kaveri", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Mullins, "mullins", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount16,
            .Movrel,
            .Gfx7Gfx8Gfx9Insts,
            .Fp64,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Localmemorysize65536,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .MimgR128,
            .SeaIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Oland, "oland", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .Movrel,
            .MimgR128,
            .Fp64,
            .TrigReducedRange,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .Localmemorysize32768,
            .SouthernIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Pitcairn, "pitcairn", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .Movrel,
            .MimgR128,
            .Fp64,
            .TrigReducedRange,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .Localmemorysize32768,
            .SouthernIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Polaris10, "polaris10", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .UnpackedD16Vmem,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Polaris11, "polaris11", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .UnpackedD16Vmem,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Stoney, "stoney", &[_]FeatureType {
            .CodeObjectV3,
            .Ldsbankcount16,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
            .Xnack,
        }),
        CpuInfo(@This(), FeatureType).create(.Tahiti, "tahiti", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .FastFmaf,
            .Ldsbankcount32,
            .Movrel,
            .MimgR128,
            .Fp64,
            .TrigReducedRange,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .Localmemorysize32768,
            .SouthernIslands,
            .HalfRate64Ops,
        }),
        CpuInfo(@This(), FeatureType).create(.Tonga, "tonga", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .SgprInitBug,
            .UnpackedD16Vmem,
            .IntClampInsts,
            .SdwaMav,
            .Movrel,
            .SMemrealtime,
            .Gcn3Encoding,
            .TrigReducedRange,
            .CiInsts,
            .FlatAddressSpace,
            .Sdwa,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .ScalarStores,
            .Gfx7Gfx8Gfx9Insts,
            .Dpp,
            .Localmemorysize65536,
            .BitInsts16,
            .VgprIndexMode,
            .Gfx8Insts,
            .Inv2piInlineImm,
            .MimgR128,
            .SdwaOutModsVopc,
            .Fp64,
            .VolcanicIslands,
        }),
        CpuInfo(@This(), FeatureType).create(.Verde, "verde", &[_]FeatureType {
            .CodeObjectV3,
            .NoXnackSupport,
            .Ldsbankcount32,
            .Movrel,
            .MimgR128,
            .Fp64,
            .TrigReducedRange,
            .Wavefrontsize64,
            .NoSramEccSupport,
            .Localmemorysize32768,
            .SouthernIslands,
        }),
    };
};
