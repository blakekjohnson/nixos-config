{
  description = "Basic configuration flake";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs?ref=nixos-unstable;
    agenix = {
      url = github:ryantm/agenix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.dev = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
        ./hosts/dev/configuration.nix
	./users/blakej/user.nix
      ];
    };
    nixosConfigurations.lab = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
        ./hosts/lab/configuration.nix
	./users/blakej/user.nix
      ];
    };
  };
}
