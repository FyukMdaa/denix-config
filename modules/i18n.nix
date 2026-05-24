{ delib, ... }:
delib.module {
  name = "i18n";
  nixos.always = { myconfig, ... }: {
    i18n.defaultLocale = myconfig.constants.mainLocale;
    console.keyMap = myconfig.constants.keymap;
  };
}
