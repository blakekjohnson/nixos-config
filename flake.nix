{
  description = "Basic configuration flake";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs?ref=nixos-unstable;
    home-manager.url = github:nix-community/home-manager;
  };

  outputs = { self, nixpkgs, ... }@inputs: {
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
