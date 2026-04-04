{ pkgs, ... }:

{
  # Containers Podman
  virtualisation.containers.enable = true;
  virtualisation.containers.policy = {
    default = [ { type = "insecureAcceptAnything"; } ];
  };

  # Libvirt / QEMU
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;
}
