{ delib, pkgs, lib, ... }:
delib.module {
  name = "graphics";

  options.graphics = with delib; {
    enable = boolOption true;
    type = noDefault (lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "amd" "nvidia" "intel" ]);
      default = null;
      description = "GPUの種類。nullの場合は基本設定のみ有効";
    });
  };

  nixos.ifEnabled = { cfg, ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = lib.mkIf (cfg.type == "intel") (with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
      ]);
    };

    hardware.amdgpu = lib.mkIf (cfg.type == "amd") {
      opencl.enable = true;
      initrd.enable = true;
    };

    hardware.nvidia = lib.mkIf (cfg.type == "nvidia") {
      modesetting.enable = true;
      nvidiaSettings = true;
    };

    services.xserver.videoDrivers = lib.mkIf (cfg.type == "nvidia") [ "nvidia" ];
  };
}
