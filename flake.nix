{
  description = "Multi-Host NixOS Flake Infrastructure";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }@inputs: {
      nixosConfigurations = {
        gamedev = nixpkgs.lib.nixosSystem {
	  system = "x86_64-linux";
	  modules = [
	    ./hosts/gamedev/configuration.nix
	  ];
	};

      # Insert Enterprise, WebDev, or Optimization hosts here
      # Generate hardware configs on install and register:
      #
      # enterprise = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [ ./hosts/enterprise/configuration.nix ];
      # };
    };
  };
}
