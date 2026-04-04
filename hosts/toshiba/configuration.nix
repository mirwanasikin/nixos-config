{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  boot.kernelPackages = pkgs.linuxPackages;

  boot.initrd.secrets = {
    "/etc/secrets/swap.key" = /etc/secrets/swap.key;
  };

  boot.initrd.luks.devices."swap" = {
    device = "/dev/disk/by-uuid/eca7241b-b49e-4fdf-87bd-b5aa75ed75c4"; # UUID sda2 baru
    keyFile = "/etc/secrets/swap.key";
  };

  swapDevices = [
    {
      device = "/dev/mapper/swap";
    }
  ];

  boot.resumeDevice = "/dev/mapper/swap";

  networking.hostName = "toshiba";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Pontianak";

  i18n.defaultLocale = "en_US.UTF-8";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.irwan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "kvm"
      "libvirtd"
      "video"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    dig
    iperf
    nmap
    tcpdump
    buildah
    skopeo
    wget
    curl
    git
    swaylock
    waybar
    rofi
    wlogout
    swaybg
    dunst
    gcc
    google-chrome
    mpv
    imv
    wayland-utils
    podman
    podman-compose
    binutils
    pciutils
    usbutils
    file
    binwalk
    gdb
    strace
    lsof
    catppuccin-sddm
  ];

  programs.sway.enable = true;
  programs.zsh.enable = true;

  services.udisks2.enable = true;
  services.dbus.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha-mauve";
    package = pkgs.kdePackages.sddm;
  };

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNS = "1.1.1.1 9.9.9.9";
        DNSOverTLS = "yes";
        DNSSSEC = "false";
        LLMNR = "false";
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    wlr.enable = true;
    config.common.default = "*";
  };

  virtualisation.containers.enable = true;
  virtualisation.containers.policy = {
    default = [ { type = "insecureAcceptAnything"; } ];
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    ipafont
    kanji-stroke-order-font
    nerd-fonts.fira-code
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  services.openssh.enable = false;

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

  system.stateVersion = "25.11";
}
