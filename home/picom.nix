{ config, pkgs, ...}: {
  services.picom = {
    enable = true;
    activeOpacity = 0.90;
  };
}

