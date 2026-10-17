_:

{
  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow Unfree for installing Proprietary Software
  nixpkgs.config.allowUnfree = true;

  # System Version
  system.stateVersion = "26.11";

  # Environment
  environment.enableAllTerminfo = true;

  # Binary
  nix.settings.substituters = [
    "https://cache.nixos.org"
    # "https://attic.xuyh0120.win/lantian"
    # "https://cache.garnix.io"
  ];

  # Checkov
  # nixpkgs.config.permittedInsecurePackages = [
  #   "python3.14-ecdsa-0.19.2"
  # ];
}
