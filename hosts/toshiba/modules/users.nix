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
      "hermes"
    ];
    shell = pkgs.fish;
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];
}
