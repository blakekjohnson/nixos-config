{
  description = "Basic configuration flake";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs?ref=nixos-unstable;
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
	./blakej.nix
      ];
    };

    nixosConfigurations.middlec = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
        ./configuration.nix
	./blakej.nix
      ];
    };
  };
}
