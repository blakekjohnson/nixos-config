{ config, pkgs, ... }:

{
  # Enable prometheus
  services.prometheus = {
    enable = true;

    exporters = {
      nginx = {
        enable = true;
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
    ];
  };
}
