{ delib, inputs, pkgs, ... }:
delib.module {
  name = "programs.mango-ext";

  options = delib.moduleOptions ({ myconfig, ... }: {  
    enable = delib.boolOption myconfig.host.mangowcFeatured;  
  });

  nixos.always = {
    imports = [
      inputs.mango-ext.nixosModules.mango-ext
    ];
  };
  
  home.always = {
    imports = [
      inputs.mango-ext.hmModules.mango-ext
    ];
  };

  nixos.ifEnabled = {
  	programs.mango-ext.enable = true;
  };
  home.ifEnabled = {
  	wayland.windowManager.mango-ext.settings = {
  		bind = [
  			"SUPER,Q,killclient"
  			"SUPER,Return,spawn,ghostty"
  			"SUPER+SHIFT,e,quit"
  			"SUPER,r,reload_config"
  			"SUPER,n,switch_layout"
  		];
  		circle_layout = "tile,scroller,canvas,dwindle";
  	};
  };
}
