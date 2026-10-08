{ pkgs, ... }:

{
  # Containers Podman
  virtualisation = {
    # Podman
    containers = {
      enable = true;
      registries.search = [
        "docker.io"
        "quay.io"
        "ghcr.io"
      ];
      policy = {
        default = [ { type = "insecureAcceptAnything"; } ];
      };
    };
    podman.enable = true;

    # Docker
    docker.enable = true;

    # VM
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
