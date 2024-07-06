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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
    shell = pkgs.zsh;
  };
}
