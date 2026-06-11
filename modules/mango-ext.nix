{ delib, inputs, pkgs, ... }:
delib.module {
  name = "programs.mango-ext";

  options = delib.moduleOptions ({ myconfig, ... }: {  
    enable = delib.boolOption myconfig.host.mangowcFeatured;  
  });

  nixos.always = {
    imports = [
      inputs.mango-ext.nixosModules.mango-ext
    ];
  };
  
  home.always = {
    imports = [
      inputs.mango-ext.hmModules.mango-ext
    ];
  };

  nixos.ifEnabled = {
  	programs.mango-ext.enable = true;
  };
  
  home.ifEnabled = {
    wayland.windowManager.mango-ext = {
      enable = true;
      settings = {
        # 環境変数
        env = [
          "NIXOS_OZONE_WL,1"
          "MOZ_ENABLE_WAYLAND,1"
          "QT_QPA_PLATFORM,wayland"
          "GTK_IM_MODULE,fcitx"
          "QT_IM_MODULE,fcitx"
          "XMODIFIERS,@im=fcitx"
        ];
  
        # キーボード
        xkb_rules_layout = "jp";
  
        # タッチパッド
        tap_to_click = 1;
        trackpad_natural_scrolling = 1;
        disable_while_typing = 1;
        trackpad_accel_speed = 0.3;
  
        # ギャップ・ボーダー
        gappih = 8;
        gappiv = 8;
        gappoh = 8;
        gappov = 8;
        borderpx = 2;
        focuscolor = "0x7dcfffff";
        bordercolor = "0x414868ff";
  
        # レイアウト
        circle_layout = "tile,scroller,canvas,dwindle";
  
        # アニメーション
        animations = 1;
        animation_type_open = "slide";
        animation_type_close = "slide";
        animation_duration_open = 150;
        animation_duration_close = 150;

        tagrule = [
          "id:1,layout_name:tile"
          "id:2,layout_name:tile"
          "id:3,layout_name:tile"
          "id:4,layout_name:tile"
          "id:5,layout_name:tile"
          "id:6,layout_name:tile"
          "id:7,layout_name:tile"
          "id:8,layout_name:tile"
          "id:9,layout_name:tile"
        ];
  
        bind = [
          # 基本
          "SUPER,Return,spawn,ghostty"
          "SUPER,D,spawn,wofi --show drun"
          "SUPER,Q,killclient"
          "SUPER+SHIFT,E,quit"
          "SUPER,r,reload_config"
          "SUPER,n,switch_layout"
          # フォーカス
          "SUPER,H,focusdir,left"
          "SUPER,L,focusdir,right"
          "SUPER,J,focusdir,down"
          "SUPER,K,focusdir,up"
          # ウィンドウ移動
          "SUPER+SHIFT,H,exchange_client,left"
          "SUPER+SHIFT,L,exchange_client,right"
          "SUPER+SHIFT,J,exchange_client,down"
          "SUPER+SHIFT,K,exchange_client,up"

          # タグへ移動
          "Super,1,toggleview,1"
          "Super,2,toggleview,2"
          "Super,3,toggleview,3"
          "Super,4,toggleview,4"
          "Super,5,toggleview,5"
          "Super,6,toggleview,6"
          "Super,7,toggleview,7"
          "Super,8,toggleview,8"
          "Super,9,toggleview,9"
          # モニター
          "SUPER,M,focusmon,prev"
          "SUPER,Comma,focusmon,next"
          "SUPER+SHIFT,M,tagmon,prev"
          "SUPER+SHIFT,Comma,tagmon,next"
        ];
      };
  
      autostart_sh = ''
        fcitx5 -d &
      '';
    };
  };
}
