{
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-config = {
      url = "github:SnaxVim/SnaxVim";
      flake = false;
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      nixpkgs-unstable,
      firefox-addons,
      neovim-config,
      ...
    }:

    let
      usr = import ./user.nix;
      inherit (usr)
        unfreePkgs
        system
        username
        hostName
        ;
      config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) unfreePkgs;
      overlays = [
        (_: _: {
          unstable = import nixpkgs-unstable {
            inherit system config;
          };
        })
        firefox-addons.overlays.default
      ];
      pkgs = import nixpkgs {
        inherit system config overlays;
      };
      extraSpecialArgs = {
        inherit username neovim-config;
      }
      // usr.extraArgs;
    in
    {
      homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./home.nix
        ];
      };
      nixosConfigurations."${hostName}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = extraSpecialArgs // {
          inherit hostName;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              inherit extraSpecialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users."${username}" = import ./home.nix;
            };
            nixpkgs = {
              inherit config overlays;
            };
          }
        ];
      };

      templates.default = {
        path = ./.;
        description = "A minimal starting point for Home Manager / NixOS";
      };
    };
}
