{delib, ...}:
delib.host {
  name = "Inspiron14-5445";

  homeManagerSystem = "x86_64-linux";
  home.home.stateVersion = "26.05";
  
  nixos = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.05";
  };

  type = "laptop";
  features = [ "nixos" "lin-gui" "lin-cli" "mangowc" ];
    
  shared.myconfig = {
  	boot.loader = "systemd-boot";
  	kernel =  {
      variant   = "cachyos-latest";
      useLTO    = true;
      archOpt   = "zen4";
    };
    graphics = {
      enable = true;
      type = "amd";
    };
    bluetooth.enable = true;
    powermanager = {
      enable = true;
      type = "auto-cpufreq";
    };
    hardware = {
    	open_tablet_driver.enable = true;
    };
  };
}
