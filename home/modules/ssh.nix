{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        addKeysToAgent = "yes";
      };

      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/key_github_irwan";
      };

      "gitlab.com" = {
        user = "git";
        identityFile = "~/.ssh/gitlab_key";
      };

      "codeberg.org" = {
        user = "git";
        identityFile = "~/.ssh/codeberg_key";
      };
    };
  };

  services.ssh-agent.enable = true;
}
