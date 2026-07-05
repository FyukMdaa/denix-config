{
  inputs,
  delib,
  pkgs,
  ...
}:
delib.overlayModule {
  name = "pkgs-overlay";
  targets = [ "nixos" "home" ];
  overlays = [
    (final: _prev: {
      stable = import inputs.nixpkgs-stable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    })
    (_final: prev: {
      lix = prev.lixPackageSets.stable;
    })
    (final: prev: 
      inputs.apple-fonts.packages.${prev.stdenv.hostPlatform.system} or {}
    )
    inputs.floorp.overlays.default
    inputs.nix-cachyos-kernel.overlays.default
    (final: prev: {
      local = builtins.listToAttrs (
        map (path: {
          name = baseNameOf (dirOf path);
          # final に allowUnfree = true の設定を強制適用したスコープを作成して callPackage
          value = (final.appendOverlays [
            (_f: _p: {
              config = (final.config or {}) // { allowUnfree = true; };
            })
          ]).callPackage path { inherit inputs; };
        }) (inputs.denix.lib.umport { path = ../packages; })
      );
    })
  ];
}
