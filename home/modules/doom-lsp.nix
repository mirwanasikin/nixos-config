{ pkgs, ... }:

# Binary LSP untuk Doom Emacs.
# extraPackages di lazyvim.nix hanya masuk ke PATH wrapper neovim,
# jadi Emacs tidak melihatnya. Paket di sini masuk ke PATH user.
# Hapus baris yang sudah kamu install di tempat lain (mis. pyright).
{
  home.packages = with pkgs; [
    # Nix
    nil
    nixfmt

    # Python
    pyright
    ruff

    # Rust (cargo/rustc/rustfmt: pakai yang sudah ada di setup Rust-mu)
    rust-analyzer

    # YAML
    yaml-language-server

    # Docker (kalau nama paket error: nix search nixpkgs dockerfile-language)
    dockerfile-language-server

    # C / C++ (clangd)
    clang-tools

    # Terraform / OpenTofu
    tofu-ls
    opentofu # dipakai tofu-ls untuk format
  ];
}
