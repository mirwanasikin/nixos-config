{ ... }:

{
  # Hostname & Network Manager
  networking.hostName = "toshiba";
  networking.networkmanager.enable = true;
  networking.hosts = {
    "127.0.0.1" = [ "myapp.com" ];
  };
  networking.wireless.enableHardening = false; # To make the wifi works in kernel 5.10. Don't Follows, after the 5.10 EOL i will removed this config

  # DNS Over TLS
  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNS = "1.1.1.1 9.9.9.9";
        FallbackDNS = "1.0.0.1 149.112.112.112";
        DNSOverTLS = "no";
        DNSSEC = "false";
        LLMNR = "false";
        Domains = "~.";
      };
    };
  };

  # Firewall & KDE Connect
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
  };
}
