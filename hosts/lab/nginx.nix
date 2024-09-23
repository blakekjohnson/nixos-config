{ config, pkgs, ... }:

{
  # Enable nginx
  services.nginx = {
    enable = true;
    statusPage = true;

    appendHttpConfig = ''
      limit_req_zone $binary_remote_addr zone=ratelimit:10m rate=10r/s;
    '';

    virtualHosts = {
      "blakekjohnson.dev" = {
        enableACME = true;
        forceSSL = true;
        root = "/var/www/blog";
        extraConfig = ''limit_req zone=ratelimit burst=20 nodelay;'';
      };
      "grafana.bonkjohnson.com" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:3000";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
        extraConfig = ''limit_req zone=ratelimit burst=20 nodelay;'';
      };
      "nextcloud.bonkjohnson.com" = {
        enableACME = true;
        forceSSL = true;
        extraConfig = ''limit_req zone=ratelimit burst=20 nodelay;'';
      };
    };
  };

  # Enable ACME
  security.acme.acceptTerms = true;
  security.acme.certs = {
    "blakekjohnson.dev".email = "blake.k.johnson.4@gmail.com";
    "grafana.bonkjohnson.com".email = "blake.k.johnson.4@gmail.com";
    "nextcloud.bonkjohnson.com".email = "blake.k.johnson.4@gmail.com";
  };
}
