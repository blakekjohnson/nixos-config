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
      hack-font
    ];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    hack-font
  ];

  home-manager.users = {
    "blakej" = {
      imports = [
        ./home.nix
      ];
    };
  };
}
