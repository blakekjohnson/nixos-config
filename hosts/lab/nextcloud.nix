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

    configureRedis = true;
    maxUploadSize = "2G";

    https = true;
    hostName = "nextcloud.bonkjohnson.com";

    config.adminpassFile = config.age.secrets.nextcloud.path;

    settings.log_type = "file";
  };
}
