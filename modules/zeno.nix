{ delib, lib, pkgs, ... }:
delib.module {
  name = "programs.zeno";
  
  options = {
    programs.zeno = {
      enable = delib.boolOption false;

      snippets = lib.mkOption {
        type = lib.types.listOf lib.types.attrs;
        default = [];
        description = "List of zeno snippets added from various modules.";
      };

      settings = lib.mkOption {
        type = lib.types.attrs;
        default = {};
        description = "Extra global settings for zeno.";
      };
    };
  };

  # Home Manager経由で.config/zeno/config.ymlを作成
  home.ifEnabled = { cfg, ... }: {
    home.packages = with pkgs; [
      deno
      fzf
    ];
    programs.zsh = {
    	antidote = {
    	  enable = true;
    	  plugins = [
    	    "yuki-yano/zeno.zsh"
    	  ];
    	};
    	initContent = ''
		  export ZENO_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}/zeno"
		  
		  if [[ -n $ZENO_LOADED ]]; then
              bindkey " " zeno-auto-snippet
              bindkey '^m' zeno-auto-snippet-and-accept-line
              bindkey '^i' zeno-completion
              bindkey '^x^p' zeno-insert-snippet
  
              bindkey '^x ' zeno-insert-space
              bindkey '^x^m' accept-line
  
              bindkey '^r' zeno-history-selection
              bindkey '^x^f' zeno-ghq-cd
          fi
    	'';
    };

    # config.yml を生成（snippetsやsettingsをマージしてJSON/YAML化）
    xdg.configFile."zeno/config.yml".text = builtins.toJSON (
      cfg.settings // {
        snippets = cfg.snippets;
      }
    );
  };
}
