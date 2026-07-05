{ delib, pkgs, ... }:
delib.module {
  name = "programs.pay-respects";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { myconfig, ... }: {
    programs.pay-respects = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
