{
  delib,
  pkgs,
  lib,
  inputs,
  ...
}:
delib.module {
  name = "programs.emacs";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    ...
  }: {
    imports = [ inputs.emacs-config.homeManagerModules.default ];
    programs.fyukmdaa-emacs.enable = true;
  };
}
