{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    signing = {
      key = "3B1B778D1D8F51B1";
      signByDefault = true;
    };
    settings = {
      user.name = "M. Irwan Asikin";
      user.email = "225542013+mirwanasikin@users.noreply.github.com";
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-tty;
    defaultCacheTtl = 28800;
    maxCacheTtl = 86400;
  };
}
