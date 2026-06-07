{ delib, pkgs, ... }:
delib.module {
  name = "programs.ghostty";

  options = delib.moduleOptions ({ myconfig, ... }: {  
    enable = delib.boolOption myconfig.host.guiFeatured;  
  });

  home.ifEnabled = {
    home.packages = [ pkgs.ghostty ];
  };
}
