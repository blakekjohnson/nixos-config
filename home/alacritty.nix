{ config, pkgs, ...}: {
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
}

