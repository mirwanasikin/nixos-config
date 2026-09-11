{ pkgs, ... }:

{
  # Programs
  programs = {
    fish.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib # libstdc++, paling sering dibutuhin
        zlib
        openssl
        curl
        icu
      ];
    };
  };
}
