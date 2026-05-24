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
    inputs.floorp.overlays.default
    inputs.nix-cachyos-kernel.overlays.default
    (_final: prev: {
      local = builtins.listToAttrs (
        map (path: {
          name = baseNameOf (dirOf path);
          value = prev.callPackage path { inherit inputs; };
        }) (inputs.denix.lib.umport { path = ../packages; })
      );
    })
  ];
}
