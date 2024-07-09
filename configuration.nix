{ config, pkgs, home-manager, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include home-manager
      home-manager.nixosModules.default

      # Include blakej user setup
      ./blakej.nix
    ];

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Set hostname
  networking.hostName = "middlec";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "92-low-latency" = {
        context.properties = {
          default.clock = {
            rate = 48000;
            quantum = 32;
            min-quantum = 32;
            max-quantum = 32;
          };
        };
      };
    };
    extraConfig.pipewire-pulse = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse = {
              min.req = "32/48000";
              default.req = "32/48000";
              max.req = "32/48000";
              min.quantum = "32/48000";
              max.quantum = "32/48000";
            };
          };
        }
      ];
      stream.properties = {
        node.latency = "32/48000";
        resample.quality = 1;
      };
    };
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Indiana/Indianapolis";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure X11
  services.xserver = {
    enable = true;

    # Configure keymap
    xkb.layout = "us";
    xkb.variant = "";

    # Enable xmonad
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hpkgs: [
        hpkgs.xmobar
      ];
    };

    displayManager.lightdm = {
      greeters.mini = {
        enable = true;
        user = "blakej";
      };
    };
  };
  services.displayManager = {
    defaultSession = "none+xmonad";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    fastfetch

    fira-code
    fira-code-symbols

    git

    zsh
    alacritty
  ];

  fonts.packages = with pkgs; [
    fira-code fira-mono
  ];

  programs.zsh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
