{ config, pkgs, ...}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    font = "Fira Code";
    location = "center";
  };
}

