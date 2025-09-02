{
  description = "Nix flake for luna system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
    neovim-flake.url = "github:jordanisaacs/neovim-flake";
    neovim-flake.inputs.nixpkgs.follows = "nixpkgs";
  nixvim.url = "github:nix-community/nixvim";
  nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, home-manager, zen-browser, neovim-flake, nixvim, ... }:
    {
      nixosConfigurations = {
        luna = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # Pass inputs (so modules like shell.nix can access inputs.catppuccin-foot)
          specialArgs = { inherit inputs; };
          modules = [
            # Ensure system build uses the neovim overlays from the inputs
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ neovim-flake.overlays.default nixvim.overlays.default ];
            })
            
            ./hosts/luna/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.luna = {
                imports = [ 
                  ./home/home.nix 
                ];
              };
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };

      homeConfigurations = {
        luna = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; overlays = [ neovim-flake.overlays.default nixvim.overlays.default ]; };
          modules = [ 
            ./home/home.nix 
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.hello;
      }
    );
}
