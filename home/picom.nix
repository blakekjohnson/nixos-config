{ config, pkgs, ...}: {
  services.picom = {
    enable = true;
    activeOpacity = 0.95;
    inactiveOpacity = 0.75;
    fade = true;
    opacityRules = [
      "100:class_g *?= 'Firefox'"
      "100:class_g *?= 'dmenu'"
    ];
    settings = {
      corner-radius = 20;
      rounded-corners-exclude = [
        "name = 'xmobar'"
      ];
    };
  };
}

