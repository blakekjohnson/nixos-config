{ config, pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 10;
        y = 10;
      };
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
}

