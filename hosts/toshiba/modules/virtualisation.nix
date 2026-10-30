{ pkgs, ... }:

{
  # Containers Podman
  virtualisation = {
    # Podman
    containers = {
      enable = true;
      policy = {
        default = [ { type = "insecureAcceptAnything"; } ];
      };
    };
    podman.enable = true;

    # Docker
    docker.enable = true;

    # Quadlet for managing podman containers via systemd
    quadlet = {
      enable = true;
      containers.hello-world = {
        containerConfig.Image = "docker.io/library/hello-world:latest";
        containerConfig.AutoUpdate = "registry";
      };
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };

  programs.virt-manager.enable = true;
}
