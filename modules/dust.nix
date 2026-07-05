{ delib, pkgs, ... }:
delib.module {
  name = "programs.dust";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { myconfig, ... }: {
    home.packages = with pkgs; [
      dust
    ];
  };
}
