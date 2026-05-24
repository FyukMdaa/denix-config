{ delib, pkgs, ... }:
delib.module {
  name = "programs.floorp";

  options = { myconfig, ... }: {
    enable = delib.boolOption myconfig.hosts.${myconfig.host}.lin-guiFeatured;
  };

  home.ifEnabled = {
    home.packages = [ pkgs.floorp-bin ];
    # Floorpの環境変数
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
