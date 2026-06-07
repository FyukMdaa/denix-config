{ delib, pkgs, ... }:
delib.module {
  name = "dbus";

  nixos.always = {
    services.dbus = {
      enable = true;
      implementation = "broker";
    };
  };
}
