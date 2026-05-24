{ delib, pkgs, lib, ... }:
delib.module {
  name = "hardware.open_tablet_driver";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = { cfg, ... }: {
  	# Enable OpenTabletDriver
  	hardware.opentabletdriver.enable = true;

  	# Required by OpenTabletDriver
  	hardware.uinput.enable = true;
  	boot.kernelModules = [ "uinput" ];
  };
}
