{ config, pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 10;
        y = 10;
      };
      font.normal = {
        family = "Noto Sans Mono";
      };
      font.bold = {
        family = "Noto Sans Mono";
      };
      font.italic = {
        family = "Noto Sans Mono";
      };
      font.bold_italic = {
        family = "Noto Sans Mono";
      };
    };
  };
}

