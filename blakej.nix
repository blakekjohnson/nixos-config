{ config, pkgs, home-manager, musnix, ... }:

{
  imports =
    [
      # Include home-manager
      home-manager.nixosModules.default

      # Include musnix
      musnix.nixosModules.default
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
    "blakej" = import ./home/home.nix;
  };
}
