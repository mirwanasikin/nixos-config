{ ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";

    containers."9router" = {
      image = "decolua/9router:0.5.75";
      autoStart = true;

      ports = [
        "127.0.0.1:20128:20128"
      ];

      volumes = [
        "/var/lib/9router:/app/data"
      ];

      environment = {
        DATA_DIR = "/app/data";
      };

      extraOptions = [
        "--pull=missing"
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/9router 0750 root root -"
  ];
}
