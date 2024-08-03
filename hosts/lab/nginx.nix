{ config, pkgs, ... }:

{
  # Enable nginx
  services.nginx = {
    enable = true;
    virtualHosts = {
      "grafana.bonkjohnson.com" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:3000";
          proxyWebsockets = true;
          recommendedProxySettings = true;
          extraConfig = ''
            proxy_ssl_server_name on;
            proxy_pass_header Authorization;
          '';
        };
      };
    };
  };

  # Enable ACME
  security.acme.acceptTerms = true;
  security.acme.certs = {
    "grafana.bonkjohnson.com".email = "blake.k.johnson.4@gmail.com";
  };
}
