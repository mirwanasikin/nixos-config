{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Nix
    nil
    nixfmt
    statix

    # Shell
    shfmt
    shellcheck

    # Docker
    hadolint
    dockerfile-language-server

    # Ansible
    ansible-lint

    # Terraform/Tofu
    tflint
    pre-commit
    tofu-ls
    # checkov

    # Markdown
    markdownlint-cli2
    marksman
    pandoc

    # C
    cppcheck
    bear
    clang-tools

    # Rust
    cargo
    rust-analyzer

    # Python
    ruff
    pyright
    python315

    # YAML
    yaml-language-server
  ];
}
