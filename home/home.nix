{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./neovim.nix
    ./xmobar.nix
    ./xmonad.nix
    ./zsh.nix
  ];

  home.username = "blakej";
  home.homeDirectory = "/home/blakej";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.dmenu
    pkgs.firefox
    pkgs.killall
  ];

  home.file = {
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  programs.git = {
    enable = true;
    userName = "Blake Johnson";
    userEmail = "blakekjohnson4@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
