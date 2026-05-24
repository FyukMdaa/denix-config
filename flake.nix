{
  description = "Modular configuration of NixOS and Home Manager with Denix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix.url = "github:musnix/musnix";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    auto-cpufreq = {
        url = "github:AdnanHodzic/auto-cpufreq";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter.url = "github:numtide/nixos-facter-modules";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango-ext = {
      url = "github:ernestoCruz05/mango-ext";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    floorp.url = "github:fyukmdaa/floorp-flake";
    twist.url = "github:emacs-twist/twist.nix";
    emacs-config.url = "github:fyukmdaa/emacs-config";    
  };

  outputs =
    { denix, ... }@inputs:
    let
      mkConfigurations =
        moduleSystem:
        denix.lib.configurations {
          inherit moduleSystem;
          homeManagerUser = "fyukmdaa";

          paths = [
            ./hosts
            ./modules
            ./overlays
          ];

          extensions = with denix.lib.extensions; [
            args
            overlays
            (base.withConfig {
              args.enable = true;
              hosts.features = {
                enable = true;
                # 利用したいロールをすべて定義します
                features = [ "nixos" "lin-gui" "mangowc" "draw" "dtm" "server" ];
                # 各名称に対して "{feature}Featured" というブール値が自動生成されます
              };
            })
          ];

          specialArgs = {
            inherit inputs;
          };
        };
    in
    {
      nixosConfigurations = mkConfigurations "nixos";
      homeConfigurations = mkConfigurations "home";
    };
}
