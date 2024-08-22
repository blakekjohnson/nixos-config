{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include common configuration
      ../common.nix

      # Include blocky setup
      ./blocky.nix

      # Include nextcloud setup
      ./nextcloud.nix

      # Include nginx setup
      ./nginx.nix
    ];

  # Set intel pstate to active
  boot.kernelParams = [ "intel_pstate=active" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set hostname
  networking.hostName = "lab";

  # Enable SSH
  services.openssh.enable = true;

  # Enable firewall ports for SSH, DNS, HTTP, and HTTPS
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 53 80 443 ];
    allowedUDPPorts = [ 22 53 80 443 ];
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
