{ delib, pkgs, lib, ... }:
delib.module {
  name = "hardware.open_tablet_driver";
  options = delib.moduleOptions ({ myconfig, ... }: {  
    enable = delib.boolOption myconfig.host.drawFeatured;  
  });

  nixos.ifEnabled = { cfg, ... }: {
  	# Enable OpenTabletDriver
  	hardware.opentabletdriver.enable = true;

  	# Required by OpenTabletDriver
  	hardware.uinput.enable = true;
  	boot.kernelModules = [ "uinput" ];
  };
}
