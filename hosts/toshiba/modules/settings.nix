{ ... }:

{
  # Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow Unfree for installing Proprietary Software
  nixpkgs.config.allowUnfree = true;

  # System Version
  system.stateVersion = "25.11";

  # Checkov
  # nixpkgs.config.permittedInsecurePackages = [
  #   "python3.14-ecdsa-0.19.2"
  # ];
}
