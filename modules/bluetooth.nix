{ delib, ... }:
delib.module {
  name = "bluetooth";
  options = delib.moduleOptions ({ myconfig, ... }: {  
    enable = delib.boolOption myconfig.host.isLaptop;  
  });
  
  nixos.ifEnabled = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };

    services.blueman.enable = true;
  };
}
