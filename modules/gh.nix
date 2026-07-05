{ delib, pkgs, ... }:
delib.module {
  name = "programs.gh";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  home.ifEnabled = { myconfig, ... }: {
    programs.gh = {
      enable = true;

      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
