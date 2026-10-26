let
  master = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbTc7icdl57ke/iEsEiwAzD05QRPrx5hoYnohTcwr21 Master key agenix";
in
{
  "github_ssh.age".publicKeys = [ master ];

  "gitlab_key.age".publicKeys = [ master ];

  "codeberg_key.age".publicKeys = [ master ];
}
