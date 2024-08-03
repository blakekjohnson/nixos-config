{ config, pkgs, ... }:

{
  # Enable nginx
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."lab.home" = {
      locations."/blocky/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.blocky.settings.ports.http}";
      };
    };
  };
}
