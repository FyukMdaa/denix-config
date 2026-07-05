{ delib, pkgs, ... }:
delib.module {
  name = "services.gvfs";

  nixos.always = {
  	services.gvfs.enable = true;
  };
}
