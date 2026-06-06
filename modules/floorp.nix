{ delib, pkgs, ... }:
delib.module {
  name = "programs.floorp";

  options = { myconfig, ... } @ args: delib.singleEnableOption myconfig.host.lin-guiFeatured args;

  home.ifEnabled = {
    home.packages = [ pkgs.floorp-bin ];
    # Floorpの環境変数
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
