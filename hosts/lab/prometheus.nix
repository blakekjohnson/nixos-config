{ config, pkgs, ... }:

{
  # Enable prometheus
  services.prometheus = {
    enable = true;

    exporters = {
      nginx = {
        enable = true;
        port = 9113;
      };
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9100;
      };
    };

    scrapeConfigs = [
      {
        job_name = "nginx-prometheus-exporter";
        static_configs = [
          { targets = [ "localhost:9113" ]; }
        ];
        scrape_interval = "10s";
      }
      {
        job_name = "node-prometheus-exporter";
        static_configs = [
          { targets = [ "localhost:9100" ]; }
        ];
        scrape_interval = "10s";
      }
    ];
  };
}
