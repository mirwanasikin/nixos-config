_:

{
  systemd.user.services.ssh-add-keys = {
    Unit = {
      Description = "Add SSH keys to agent on boot";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/foot -e ssh-add ~/.ssh/key_github_irwan ~/.ssh/gitlab_key ~/.ssh/codeberg_key";
      Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.ssh-add-keys = {
    Unit = {
      Description = "Run ssh-add-keys service at boot";
    };
    Timer = {
      OnBootSec = "10s";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
