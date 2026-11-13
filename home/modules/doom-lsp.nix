{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Rust (cargo/rustc/rustfmt: pakai yang sudah ada di setup Rust-mu)

    # Docker (kalau nama paket error: nix search nixpkgs dockerfile-language)
  ];
}
