{ delib, ... }:
delib.module {
  name = "constants";

  options =
    with delib;
    moduleOptions {

      username = strOption "fyukmdaa";
      userfullname = strOption "FyukMdaa";
      useremail = strOption "fyukmdaa@tutanota.com";
      mainLocale = strOption "ja_JP.UTF-8";

      screenshots = strOption "$HOME/Pictures/Screenshots";
      keyboardLayout = strOption "jp";
      keymap = strOption "jp106";
      keyboardVariant = strOption "";

      weather = strOption "Fukuoka";
      timeZone = strOption "Asia/Tokyo";
    };

  myconfig.always =
    { cfg, ... }:
    {
      args.shared.constants = cfg;
    };
}
