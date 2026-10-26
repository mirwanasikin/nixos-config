{ config, ... }:

{
  age = {
    identityPaths = [ "/home/irwan/.ssh/id_nixos" ];

    secrets = {
      # Gitlab key IMPORTANT!
      gitlab-ssh = {
        file = ../../../secrets/gitlab_key.age;
        path = "/home/irwan/.ssh/gitlab_key";
        owner = "irwan";
        mode = "600";
      };

      # Github Key
      github-ssh = {
        file = ../../../secrets/github_ssh.age;
        path = "/home/irwan/.ssh/key_github_irwan";
        owner = "irwan";
        mode = "600";
      };

      # Codeberg Key
      codeberg-ssh = {
        file = ../../../secrets/codeberg_key.age;
        path = "/home/irwan/.ssh/codeberg_key";
        owner = "irwan";
        mode = "600";
      };
    };
  };
}
