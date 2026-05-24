{ delib, pkgs, ... }:
delib.module {
  name = "programs.fcitx5";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    i18n = {
      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          addons = with pkgs; [
            fcitx5-gtk
            fcitx5-skk
            fcitx5-mozc
            fcitx5-nord
          ];
          waylandFrontend = true;
        };
      };
    };

    # Set skk dictonaries
    environment.systemPackages = with pkgs.skkDictionaries; [
      l
      jinmei
      fullname
      geo
      propernoun
      station
      law
      emoji
    ];
  };
}
