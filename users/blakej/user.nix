{ config, pkgs, home-manager, ... }:

{
  imports =
    [
      # Include home-manager
      home-manager.nixosModules.default
    ];

  users.users.blakej = {
    isNormalUser = true;
    description = "Blake Johnson";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [
      hack-font
    ];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    hack-font
  ];

  home-manager.users = {
    "blakej" = {
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
        pkgs.bat
        pkgs.firefox
        pkgs.killall
        pkgs.pavucontrol
        pkgs.scrot
        pkgs.tree
      ];

      home.shellAliases = {
        vim = "nvim";
        vi = "nvim";
      };

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
        extraConfig = {
          core.editor = "nvim"; 
        };
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
  };
}
