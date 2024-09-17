{ config, pkgs, ... }:

{
  # Enable fail2ban
  services.fail2ban = {
    enable = true;
    maxretry = 10;

    ignoreIP = [
      "10.0.0.0/8" "192.168.0.0/16"
    ];

    bantime = "24h";
    bantime-increment = {
      enable = true;
      formula = "ban.Time * math.exp(float(ban.Count + 1) * banFactor) / math.exp(1 * banFactor)";
      maxtime = "168h";
      overalljails = true;
    };

    jails = {
      # Jail for nextcloud
      nextcloud.settings = {
        enabled = true;
        filter = "nextcloud";
        backend = "auto";
        port = "80, 443";
        protocol = "tcp";
        logpath = "/var/lib/nextcloud/data/nextcloud.log";
        findtime = 43200;
        bantime = 86400;
        maxretry = 3;
      };

      # Example scanning jail
      apache-nohome-iptables.settings = {
        enabled = true;
        filter = "apache-nohome";
        backend = "auto";
        action = ''iptables-multiport[name=HTTP, port="http,https"]'';
        logpath = "/var/log/httpd/error_log*";
        findtime = 600;
        bantime = 600;
        maxretry = 5;
      };
    };
  };

  # Setup specific filters and actions for fail2ban
  environment.etc = {
    # Filter for nextcloud
    "fail2ban/filter.d/nextcloud.conf".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
      [Definition]
      _groupsre = (?:(?:,?\s*"\w+":(?:"[^"]+"|\w+))*)
      failregex = ^\{%(_groupsre)s,?\s*"remoteAddr":"<HOST>"%(_groupsre)s,?\s*"message":"Login failed:
                  ^\{%(_groupsre)s,?\s*"remoteAddr":"<HOST>"%(_groupsre)s,?\s*"message":"Trusted domain error.
      datepattern = ,?\s*"time"\s*:\s*"%%Y-%%m-%%d[T ]%%H:%%M:%%S(%%z)?"
    '');
  };
}
