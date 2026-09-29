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

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      sharedModules = [
        ./modules/core/base.nix
        ./users/zahir/user.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.zahir = import ./users/zahir/home.nix;
        }
      ];
    in
    {
      nixosConfigurations = {
        Desktop = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = sharedModules ++ [
            ./hosts/Desktop
            ./profiles/desktop
            ./profiles/nvidia
            ./profiles/gamedev
            ./profiles/games
          ];
        };

        Victus = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = sharedModules ++ [
            ./hosts/HP_Victus_15
            ./profiles/desktop
            ./profiles/nvidia
            ./profiles/appdev
            ./profiles/databases
          ];
        };

        Toshiba = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = sharedModules ++ [
            ./hosts/Toshiba_Satellite
            ./profiles/desktop
            ./profiles/webdev
            ./profiles/databases
          ];
        };

        Exo = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = sharedModules ++ [
            ./hosts/Exo_Netbook
          ];
        };
      };
    };
}
