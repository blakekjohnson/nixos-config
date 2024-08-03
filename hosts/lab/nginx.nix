{ config, pkgs, ... }:

{
  # Enable nginx
  services.nginx = {
    enable = true;
  };
}
