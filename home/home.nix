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
    pkgs.ardour
    pkgs.audacity
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

  slippi = {
    launcher = {
      isoPath = "/home/blakej/Downloads/melee.iso";
      launchMeleeOnPlay = false;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
