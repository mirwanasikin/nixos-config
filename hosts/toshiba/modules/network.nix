{ ... }:

{
  # Networking
  networking = {
    hostName = "toshiba";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  # DNS
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
}
