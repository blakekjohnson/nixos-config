{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include common configuration
      ../common.nix
    ];

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Set hostname
  networking.hostName = "dev";

  system.stateVersion = "24.05"; # Did you read the comment?
}
