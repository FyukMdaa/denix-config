{delib, 
lib,
modulesPath,
...}:
delib.host {
  name = "Inspiron14-5445";

  nixos = {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
      initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usb_strage"
        "usbhid"
        "sd_mod"
      ];
      initrd.kernelModules = [ ];
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/ff516841-b219-4ec2-8510-b71d31d17d99";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/3A79-8DB7";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    swapDevices = [];

    hardware.facter.reportPath = ./facter.json;
  };

}
