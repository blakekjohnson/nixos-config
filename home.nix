{ config, pkgs, ... }:

{
  home.username = "blakej";
  home.homeDirectory = "/home/blakej";

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.firefox
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "Full";
      font.normal = {
        family = "Fira Code";
      };
      font.bold = {
        family = "Fira Code";
      };
      font.italic = {
        family = "Fira Code";
      };
      font.bold_italic = {
        family = "Fira Code";
      };
    };
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

  programs.git = {
    enable = true;
    userName = "Blake Johnson";
    userEmail = "blakekjohnson4@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
