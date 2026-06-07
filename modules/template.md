``` nix
{ delib, pkgs, ... }:
delib.module {
  name = "template";

  options = delib.moduleOptions ({ myconfig, ... }: {
    enable = delib.boolOption myconfig.host.guiFeatured;
    enable = delib.boolOption myconfig.host.isLaptop;
  });
  options = delib.singleEnableOption true;
  
  nixos.ifEnabled = {};
  nixos.ifDisabled = {};
  nixos.allways = {};
  home.ifEnabled = {};
  home.ifDisabled = {};
  home.allways = {};
}
```
