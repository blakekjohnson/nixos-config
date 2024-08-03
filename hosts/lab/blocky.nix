{ config, pkgs, ... }

{
  # Enable blocky
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53;
      ports.http = 4000;

      prometheus.enable = true;

      upstreams.groups.default = [
        "tcp-tls:1.1.1.1:853"
      ];

      blocking = {
        blackLists = {
          general = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts"
          ];
          abuse = [
            "https://blocklistproject.github.io/Lists/abuse.txt"
          ];
          ads = [
            "https://adaway.org/hosts.txt"
            "https://v.firebog.net/hosts/AdguardDNS.txt"
            "https://blocklistproject.github.io/Lists/ads.txt"
          ];
          fraud = [
            "https://blocklistproject.github.io/Lists/fraud.txt"
          ];
          malware = [
            "https://blocklistproject.github.io/Lists/malware.txt"
          ];
          phishing = [
            "https://blocklistproject.github.io/Lists/phishing.txt"
          ];
          ransomware = [
            "https://blocklistproject.github.io/Lists/ransomware.txt"
          ];
          scam = [
            "https://blocklistproject.github.io/Lists/scam.txt"
          ];
        };
        clientGroupsBlock = {
          default = [
            "general"
            "abuse"
            "ads"
            "fraud"
            "malware"
            "phishing"
            "ransomware"
            "scam"
          ];
        };
      };

      clientLookup = {
        upstream = "10.0.0.1";
        singleNameOrder = [ 1 ];
      };
    };
  };
}
