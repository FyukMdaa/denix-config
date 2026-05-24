{ delib, pkgs, lib, ... }:
delib.module {
  name = "kernel";

  options.kernel = with delib; {
    variant = noDefault (lib.mkOption {
      type = lib.types.enum [
        "latest" "zen" "xanmod"
        "cachyos-latest" "cachyos-bore" "cachyos-deckify"
      ];
      default = "latest";
      description = "使用するカーネル";
    });

    useLTO = lib.mkEnableOption "Clang + ThinLTO（cachyos系のみ有効）" // { default = true; };

    archOpt = noDefault (lib.mkOption {
      type = lib.types.enum [ "generic" "x86_64-v3" "x86_64-v4" "zen4" ];
      default = "generic";
      description = "アーキテクチャ最適化（LTO有効時のみ）";
    });
  };

  nixos.always = { cfg, ... }:
    let
      isCachyos = lib.hasPrefix "cachyos" cfg.variant;

      # cachyos系: パッケージ名を組み立てる
      # linux-cachyos-<variant>[-lto[-<arch>]]
      cachyosName =
        let
          base   = "linux-${cfg.variant}";
          ltoSfx = if cfg.useLTO then "-lto" else "";
          archSfx =
            if cfg.useLTO && cfg.archOpt != "generic"
            then "-${cfg.archOpt}"
            else "";
        in
          "${base}${ltoSfx}${archSfx}";

      cachyosPkg = pkgs.linuxPackagesFor pkgs.cachyosKernels.${cachyosName}
        or (throw "cachyos kernel not found: ${cachyosName}");

      nonCachyosPkg = {
        latest = pkgs.linuxPackages_latest;
        zen    = pkgs.linuxPackages_zen;
        xanmod = pkgs.linuxPackages_xanmod_latest;
      }.${cfg.variant};
    in {
      boot.kernelPackages =
        if isCachyos then cachyosPkg
        else nonCachyosPkg;

      boot.kernelPatches = [{
            name = "fix-nfs-interactive";
            patch = null;
            structuredExtraConfig = with lib.kernel; {
              NFS_FS = module;           # m
              NFS_V2 = module;           # m
              NFS_V3 = yes;              # y
              NFS_V3_ACL = yes;          # y
              NFS_V4 = yes;              # y
              NFS_SWAP = yes;            # y
              NFS_V4_0 = yes;            # y
              # 出てきたら追加していく
              # NFS_V4_1 = yes;
              # NFS_V4_2 = yes;
            };
          }];
    };
}
