_:

{
  # Networking
  networking = {
    hostName = "toshiba";
    networkmanager.enable = true;

    hosts = {
      "127.0.0.1" = [ "9router.irwan.local" ];
    };

    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      interfaces.lo.allowedTCPPorts = [
        80
        443
      ];
    };
  };

  services = {
    # DNS
    resolved = {
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

    # Caddy
    caddy = {
      enable = true;
      virtualHosts."9router.irwan.local" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:20128
        '';
      };
    };
  };
}
