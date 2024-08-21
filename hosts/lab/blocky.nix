{ config, pkgs, ... }:

{
  # Enable blocky
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53;
      ports.http = 4000;

      upstreams.groups.default = [
        "tcp-tls:1.1.1.1:853"
        "https:1.1.1.1"
      ];

      customDNS = {
        customTTL = "1h";
        mapping = {
          "dev.lan" = "192.168.0.139";
          "lab.lan" = "192.168.0.207";
          "router.lan" = "192.168.0.1";
          "att.lan" = "192.168.1.254";
          "nextcloud.bonkjohnson.com" = "192.168.0.207";
        };
      };

      blocking = {
        loading = {
          strategy = "fast";
        };
        denylists = {
          ads = [ "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt" ];
        };
        clientGroupsBlock = {
          default = [
            "ads"
          ];
        };
      };

      clientLookup = {
        upstream = "10.0.0.1";
        singleNameOrder = [ 1 ];
      };

      caching = {
        minTime = "5m";
        maxTime = "1h";
        prefetching = true;
      };
    };
  };
}
