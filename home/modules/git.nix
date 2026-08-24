{ ... }:
{
  programs.git = {
    enable = true;
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

}
