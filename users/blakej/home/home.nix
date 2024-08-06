{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./neovim.nix
    ./picom.nix
    ./rofi.nix
    ./xmobar.nix
    ./xmonad.nix
    ./zsh.nix
  ];

  home.username = "blakej";
  home.homeDirectory = "/home/blakej";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.audacity
    pkgs.firefox
    pkgs.killall
    pkgs.pavucontrol
    pkgs.scrot
    pkgs.tree
  ];

  home.shellAliases = {
    vim = "nvim";
    vi = "nvim";
  };

  home.file = {
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  services.screen-locker = {
    enable = true;
    xautolock.enable = true;
    lockCmd = "${pkgs.slock}/bin/slock";
    inactiveInterval = 5;
  };

  programs.git = {
    enable = true;
    userName = "Blake Johnson";
    userEmail = "blake.k.johnson.4@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
