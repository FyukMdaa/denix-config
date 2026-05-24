{ delib, pkgs, ... }:
delib.module {
  name = "programs.floorp";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [ pkgs.floorp-bin ];
    # Floorpの環境変数
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
