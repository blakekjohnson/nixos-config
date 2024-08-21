{ config, pkgs, home-manager, ... }:

{
  imports =
    [
      # Include home-manager
      home-manager.nixosModules.default
    ];

  users.users.blakej = {
    isNormalUser = true;
    description = "Blake Johnson";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  home-manager.users = {
    "blakej" = {
      imports = [
        ./home.nix
      ];
    };
  };
}
