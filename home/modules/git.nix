_: {
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "M. Irwan Asikin";
        user.email = "mirwanasikin@proton.me";
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
