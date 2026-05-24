{ delib, lib, ... }:
delib.module {
  name = "boot";

  options.boot = with delib; {
    loader = noDefault (lib.mkOption {
      type = lib.types.enum [ "systemd-boot" "grub" ];
      default = "systemd-boot";
    });
  };

  nixos.always = { cfg, ... }: {
    boot = {
      loader = {
        systemd-boot = lib.mkIf (cfg.loader == "systemd-boot") {
          enable = true;
          configurationLimit = 10;
        };
        grub = lib.mkIf (cfg.loader == "grub") {
          enable = true;
          device = "nodev";
          efiSupport = true;
          configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
      };
      consoleLogLevel = 0;
      plymouth.enable = true;
    };
  };
}
