{ delib, config, ... }:
delib.module {
  name = "zsh";
  options = delib.singleEnableOption true;
  home.ifEnabled = { cfg, myconfig, ... }: let
    inherit (myconfig.constants) username;
    homeConfig = if config ? home-manager
                 then config.home-manager.users.${username}
                 else config;
  in {
    programs.zsh = {
      enable = true;
      dotDir = "${homeConfig.xdg.configHome}/zsh";
      defaultKeymap = "emacs";
      enableCompletion = true;
      autosuggestion.enable = false;
      syntaxHighlighting.enable = false;
      history = {
        size = 10000;
        save = 10000;
        path = "\${XDG_DATA_HOME}/zsh/history";
        ignoreDups = true;
        ignoreSpace = true;
        extended = true;
        share = true;
      };
      sessionVariables = {};
      autocd = true;
      historySubstringSearch.enable = true;
      completionInit = ''
        autoload -Uz compinit
        setopt EXTENDEDGLOB
        local zcompdump="$XDG_CACHE_HOME/zsh/zcompdump"
        if [[ -n $zcompdump(#qNmh-24) ]]; then
          compinit -C -d "$zcompdump"
        else
          compinit -d "$zcompdump"
          { rm -f "$zcompdump.zwc" && zcompile "$zcompdump" } &!
        fi
      '';
      antidote = {
        enable = true;
        plugins = [
          "zdharma-continuum/fast-syntax-highlighting kind:defer"
          "marlonrichert/zsh-autocomplete"
          "hlissner/zsh-autopair kind:defer"
          "Aloxaf/fzf-tab"
          "chrissicool/zsh-bash"
        ];
      };
      initContent = ''
        unsetopt CORRECT
        unsetopt BEEP
        setopt GLOB_DOTS
        setopt INTERACTIVE_COMMENTS
        zstyle ':completion:*' menu select
        zstyle ':completion:*' rehash true
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        zstyle ':autocomplete:*' min-input 2
        zstyle ':autocomplete:*' max-lines 10
        zstyle ':autocomplete:tab:*' widget-style menu-select
        mkcd() {
          mkdir -p "$1" && cd "$1"
        }
      '';
    };
    home.activation.setupZshDirs = homeConfig.lib.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p "$XDG_CACHE_HOME/zsh/zcompcache"
      $DRY_RUN_CMD mkdir -p "$XDG_DATA_HOME/zsh"
    '';
  };
}
