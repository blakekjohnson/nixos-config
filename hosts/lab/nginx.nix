{ config, pkgs, ... }:

{
  # Enable nginx
  services.nginx = {
    enable = true;
    statusPage = true;

    virtualHosts = {
      "blakekjohnson.dev" = {
        enableACME = true;
        forceSSL = true;
        root = "/var/www/blog";
      };
      "ge-homecare.blakekjohnson.dev" = {
        enableACME = true;
        forceSSL = true;
        root = "/var/www/ge-homecare";
      };
      "grafana.bonkjohnson.com" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:3000";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      "nextcloud.bonkjohnson.com" = {
        enableACME = true;
        forceSSL = true;
      };
    };
  };

  # Enable ACME
  security.acme.acceptTerms = true;
  security.acme.certs = {
    "blakekjohnson.dev".email = "blake.k.johnson.4@gmail.com";
    "grafana.bonkjohnson.com".email = "blake.k.johnson.4@gmail.com";
    "nextcloud.bonkjohnson.com".email = "blake.k.johnson.4@gmail.com";
    "ge-homecare.blakekjohnson.dev".email = "blake.k.johnson.4@gmail.com";
  };
}
