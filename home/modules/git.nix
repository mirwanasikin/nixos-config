_: {
  programs = {
    git = {
      enable = true;
      signing = {
        key = "~/.ssh/id_nixos.pub";
        signByDefault = true;
      };

      settings = {
        user.name = "M. Irwan Asikin";
        user.email = "mirwanasikin@proton.me";
        init.defaultBranch = "main";
        pull.rebase = false;
        gpg.format = "ssh";
        commit.gpgsign = true;
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        side-by-side = true;
      };
    };
  };
}
