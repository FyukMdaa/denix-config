{ delib, pkgs, ... }:
delib.module {
  name = "programs.keyroost";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.token2Featured;
  });

  home.ifEnabled = { myconfig, ... }: {
    home.packages = with pkgs; [
      keyroost
    ];
  };
}
