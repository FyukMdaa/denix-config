{
  delib,
  host,
  ...
}:
delib.module {
  name = "networking";

  options.networking = with delib; {
    nameservers = listOfOption str [
      "1.1.1.1"
      "1.0.0.1"
    ];
    hosts = attrsOfOption (listOf str) { };
  };

  nixos.always =
    { cfg, myconfig, ... }:let
      inherit (myconfig.constants) username;
    in {
      networking = {
        hostName = host.name;

        firewall.enable = true;
        networkmanager.enable = true;

        networkmanager.dns = "default";

        inherit (cfg) hosts nameservers;
      };

      users.users.${username}.extraGroups = [ "networkmanager" ];
    };
}

