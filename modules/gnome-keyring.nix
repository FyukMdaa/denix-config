{ delib, pkgs, ... }:
delib.module {
  name = "services.gnome-keyring";

  nixos.always = {
    services.gnome.gnome-keyring = {
      enable = true;
    };
  };
}
