{ config, pkgs, ...}:

{
  age.secrets = {
    nextcloud = {
      file = ../../secrets/nextcloud.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    hostName = "nextcloud.bonkjohnson.com";
    config.adminpassFile = config.age.secrets.nextcloud.path;
    https = true;
    configureRedis = true;
  };
}
