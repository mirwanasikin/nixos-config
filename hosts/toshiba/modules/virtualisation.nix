{ pkgs, ... }:

{
  # Containers Podman
  virtualisation = {
    # Podman
    containers = {
      enable = false;
      policy = {
        default = [ { type = "insecureAcceptAnything"; } ];
      };
    };

    # Docker
    docker.enable = true;

    # VM
    libvirtd = {
      enable = false;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };

  programs.virt-manager.enable = false;
}
