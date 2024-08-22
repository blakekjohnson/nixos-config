{ config, pkgs, ...}:
let
  fontFamily = "Hack";
in {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = fontFamily;
        bold.family = fontFamily;
        italic.family = fontFamily;
        bold_italic.family = fontFamily;
      };

      window.padding = {
        x = 10;
        y = 10;
      };
    };
  };
}

