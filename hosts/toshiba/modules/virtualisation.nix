{ pkgs, ... }:

{
  # Containers Podman
  virtualisation.containers.enable = false;
  virtualisation.containers.policy = {
    default = [ { type = "insecureAcceptAnything"; } ];
  };

  # Containers Docker
  virtualisation.docker.enable = false;

  # Libvirt / QEMU
  virtualisation.libvirtd = {
    enable = false;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = false;
    };
  };

  programs.virt-manager.enable = false;
}
