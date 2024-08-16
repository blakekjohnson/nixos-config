{ config, pkgs, ... }:

{
  # Enable nginx
  services.nginx = {
    enable = true;
    virtualHosts = {
      "nextcloud.bonkjohnson.com" = {
        enableACME = true;
        forceSSL = true;
      };
    };
  };

  # Enable ACME
  security.acme.acceptTerms = true;
  security.acme.certs = {
    "nextcloud.bonkjohnson.com".email = "blake.k.johnson.4@gmail.com";
  };
}
