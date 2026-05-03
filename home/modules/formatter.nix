{ pkgs, ... }:

{
  # Formatter I Need
  home.packages = with pkgs; [
    # Shell
    shfmt
    shellcheck

    # Nix
    nil
    nixfmt

    # Python
    pyright
    ruff

    # yaml / config
    yaml-language-server
    prettier

    # Docker
    dockerfile-language-server
    docker-compose-language-service
    hadolint

    # Ansible
    ansible-lint

    # terrafrom
    terraform-ls
    tflint

    # Markdown
    markdownlint-cli2
    marksman

    # C
    clang-tools
    cppcheck
    bear
  ];
}
