{ delib, pkgs, ... }:
delib.module {
  name = "programs.git";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.cliFeatured;
  });

  nixos.ifEnabled.environment.systemPackages = [pkgs.git];
  
  home.ifEnabled = { myconfig, ... }: {
    programs.git = {
      enable = true;
      lfs.enable = true;
      
      settings = {
      	user.name = myconfig.constants.username;
      	user.email = myconfig.constants.useremail;
      	pull.rebase = true;
      	push.autoSetupRemote = true;
      };
    };
  };

  myconfig.ifEnabled = {
    programs.zeno.snippets = [
      {
	    name = "git commit";
	    keyword = "gtcm";
	    snippet = "git commit -m '{{commit_message}}'";
      }
    ];
  };
}
