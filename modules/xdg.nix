{ delib, ... }:

delib.module {
  name = "xdg";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = { ... }: {
    environment.sessionVariables = {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";
    };
  };

  home.ifEnabled = { ... }: {
    xdg = {
      enable = true;

      userDirs = {
        enable = true;
        createDirectories = true;
        desktop     = "$HOME/Desktop";
        documents   = "$HOME/Documents";
        download    = "$HOME/Downloads";
        music       = "$HOME/Music";
        pictures    = "$HOME/Pictures";
        publicShare = "$HOME/Public";
        templates   = "$HOME/Templates";
        videos      = "$HOME/Videos";
      };
    };
  };
}
