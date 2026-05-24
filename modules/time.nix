{ delib, ... }:
delib.module {
  name = "time";
  nixos.always = { myconfig, ... }: {
    time.timeZone = myconfig.constants.timeZone;
  };
}
