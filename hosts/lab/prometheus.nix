{ config, pkgs, ... }:

{
  # Enable prometheus
  services.prometheus = {
    enable = true;
  };
}
