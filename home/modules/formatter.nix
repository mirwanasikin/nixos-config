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

    # Ansible
    ansible-lint

    # Terraform/Tofu
    tflint
    pre-commit
    # checkov

    # Markdown
    markdownlint-cli2
    marksman
    pandoc

    # C
    cppcheck
    bear

    # Rust
    cargo
  ];
}
