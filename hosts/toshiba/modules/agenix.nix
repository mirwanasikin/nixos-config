{ config, ... }:

{
  age.identityPaths = [ "/home/irwan/.ssh/id_nixos" ];

  age.secrets.github-ssh = {
    file = ../../../secrets/github_ssh.age;
    path = "/home/irwan/.ssh/key_github_irwan";
    owner = "irwan";
    mode = "600";
  };

  age.secrets.gitlab-ssh = {
    file = ../../../secrets/gitlab_key.age;
    path = "/home/irwan/.ssh/gitlab_key";
    owner = "irwan";
    mode = "600";
  };

  age.secrets.codeberg-ssh = {
    file = ../../../secrets/codeberg_key.age;
    path = "/home/irwan/.ssh/codeberg_key";
    owner = "irwan";
    mode = "600";
  };

  age.secrets.aws-ec2 = {
    file = ../../../secrets/aws_ec2_pem.age;
    path = "/home/irwan/.ssh/test_1.pem";
    owner = "irwan";
    mode = "600";
  };

  age.secrets.aws-creds = {
    file = ../../../secrets/aws_creds.age;
    path = "/home/irwan/.aws/credentials";
    owner = "irwan";
  };
}
