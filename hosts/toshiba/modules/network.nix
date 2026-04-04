{ ... }:

{
  # Hostname & Network Manager
  networking.hostName = "toshiba";
  networking.networkmanager.enable = true;

  # DNS Over TLS
  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNS = "1.1.1.1 9.9.9.9";
        DNSOverTLS = "yes";
        DNSSEC = "false";
        LLMNR = "false";
      };
    };
  };

  # Firewall & KDE Connect
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
