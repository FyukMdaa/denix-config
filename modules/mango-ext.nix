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

        # マウス
        sloppyfocus = 0;
        drag_tile_to_tile = 1;
        mousebind = [
        	"SUPER,BTN_LEFT,moveresize,curmove"
        	"SUPER, BTN_RIGHT, canvas_drag_pan"
        ];

        # モニター
        focus_cross_monitor = 1;
        exchange_cross_monitor = 1;
        
        # ギャップ・ボーダー
        gappih = 8;
        gappiv = 8;
        gappoh = 8;
        gappov = 8;
        borderpx = 2;
        focuscolor = "0x7dcfffff";
        bordercolor = "0x414868ff";
        border_radius = 10;
  
        # レイアウト
        circle_layout = "tile,scroller,canvas";
  
        # アニメーション
        animations = 1;
        animation_type_open = "slide";
        animation_type_close = "slide";
        animation_duration_open = 150;
        animation_duration_close = 150;

        # タグ
        tag_animation_direction = 0;
        tagrule = [
          "id:1,layout_name:scroller"
          "id:2,layout_name:scroller"
          "id:3,layout_name:scroller"
          "id:4,layout_name:scroller"
          "id:5,layout_name:scroller"
          "id:6,layout_name:scroller"
          "id:7,layout_name:scroller"
          "id:8,layout_name:scroller"
          "id:9,layout_name:scroller"
        ];
  
        bind = [
          # 基本
          "SUPER,Return,spawn,ghostty"
          "SUPER,D,spawn,wofi --show drun"
          "SUPER,Q,killclient"
          "SUPER+SHIFT,E,quit"
          "SUPER,r,reload_config"
          "SUPER,n,switch_layout"
          "SUPER,m,togglemaximizescreen"
          
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
          # ウィンドウリサイズ
          "SUPER+CTRL,K,resizewin,+0,-50"
          "SUPER+CTRL,J,resizewin,+0,+50"
          "SUPER+CTRL,H,resizewin,-50,+0"
          "SUPER+CTRL,L,resizewin,+50,+0"

          # タグへ移動
          "Super,1,view,1,0"
          "Super,2,view,2,0"
          "Super,3,view,3,0"
          "Super,4,view,4,0"
          "Super,5,view,5,0"
          "Super,6,view,6,0"
          "Super,7,view,7,0"
          "Super,8,view,8,0"
          "Super,9,view,9,0"

          "SUPER+SHIFT,1,tag,1,0"
          "SUPER+SHIFT,2,tag,2,0"
          "SUPER+SHIFT,3,tag,3,0"
          "SUPER+SHIFT,4,tag,4,0"
          "SUPER+SHIFT,5,tag,5,0"
          "SUPER+SHIFT,6,tag,6,0"
          "SUPER+SHIFT,7,tag,7,0"
          "SUPER+SHIFT,8,tag,8,0"
          "SUPER+SHIFT,9,tag,9,0"
        ];
      };
  
      autostart_sh = ''
        fcitx5 -d &
      '';
    };
  };
}
