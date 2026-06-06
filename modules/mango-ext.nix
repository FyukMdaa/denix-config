{ delib, inputs, pkgs, ... }:
delib.module {
  name = "programs.mango-ext";

  options = { myconfig, ... } @ args: delib.singleEnableOption myconfig.host.mangowcFeatured args;

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

  nixos.ifEnabled ={
  	programs.mango-ext.enable = true;
  };
}
