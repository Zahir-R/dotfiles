{
  description = "Multi-Host NixOS Flake Infrastructure";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    sharedModules = [
      ./modules/core/base.nix
      ./users/zahir/user.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.zahir = import ./users/zahir/home.nix;
      }
    ];
  in {
    nixosConfigurations = {
      gamedev = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = sharedModules ++ [
          ./hosts/gamedev/configuration.nix
          ./modules/hardware/nvidia.nix
          ./modules/desktop/default.nix
          ./modules/dev/gamedev/default.nix
        ];
      };

      webwork = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = sharedModules ++ [
          ./hosts/webwork/configuration.nix
          ./modules/hardware/nvidia.nix
          ./modules/desktop/default.nix
          ./modules/dev/webfull/default.nix
          ./modules/services/databases.nix
        ];
      };

      weblight = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = sharedModules ++ [
          ./hosts/weblight/configuration.nix
          ./modules/desktop/default.nix
          ./modules/dev/weblight/default.nix
          ./modules/services/databases.nix
        ];
      };

      microserver = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = sharedModules ++ [
          ./hosts/microserver/configuration.nix
        ];
      };
    };
  };
}
