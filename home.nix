{ config, pkgs, ... }:

{
  home.username = "blakej";
  home.homeDirectory = "/home/blakej";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.alacritty
    pkgs.firefox
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [];
      theme = "lukerandall";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
