{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./neovim.nix
    ./picom.nix
    ./xmobar.nix
    ./xmonad.nix
    ./zsh.nix
  ];

  home.username = "blakej";
  home.homeDirectory = "/home/blakej";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.ardour
    pkgs.audacity
    pkgs.dmenu
    pkgs.firefox
    pkgs.killall
    pkgs.pavucontrol
    pkgs.scrot
  ];

  home.file = {
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  programs.git = {
    enable = true;
    userName = "Blake Johnson";
    userEmail = "blake.k.johnson.4@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
