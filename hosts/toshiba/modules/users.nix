{ pkgs, ... }:

{
  users.users.irwan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "kvm"
      "libvirtd"
      "video"
      "docker"
    ];
    shell = pkgs.zsh;
  };
}
