{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "fonts";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled = {
      fonts = {
        packages = with pkgs; [
          # 日本語フォント
          noto-fonts
          noto-fonts-cjk-serif
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
    
          # プログラミングフォント
          plemoljp-nf
          hackgen-nf-font
          moralerspace-hw
    
          # アイコンフォント
          font-awesome
          material-design-icons

          # Apple fonts
          local.sfmono-square
          sf-pro
          sf-compact
          sf-mono
          ny
        ];
    
        fontDir.enable = true;
    
        fontconfig = {
          enable = true;
          defaultFonts = {
            serif = [
              "Noto Serif CJK JP"
              "Noto Color Emoji"
            ];
            sansSerif = [
              "Noto Sans CJK JP"
              "Noto Color Emoji"
            ];
            monospace = [
              "SF Mono Square Regular"
              "Noto Color Emoji"
            ];
            emoji = ["Noto Color Emoji"];
          };
        };
      };
  };
}
