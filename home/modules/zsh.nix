{
  config,
  pkgs,
  lib,
  ...
}:

let
  homeDir = config.home.homeDirectory;
  kdeConnectDeviceId = "ecc1eb827f474ec9af7e269c5dae053a";
in

{

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    history = {
      path = "${homeDir}/.zsh_history";
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
    };

    enableCompletion = true;
    completionInit = ''
      zstyle ':completion:*' menu select
    '';

    initContent = lib.mkMerge [
      (lib.mkOrder 550 ''
        ZVM_INIT_MODE=sourcing
      '')

      ''
        if [[ -z "$SSH_CONNECTION" ]]; then
          fastfetch
        fi

        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          exec dbus-run-session sway
        fi

        eval "$(atuin init zsh)"
      ''
    ];

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    shellAliases = {
      # System
      cl = "clear";
      suspend = "sudo systemctl suspend";
      reboot = "sudo reboot now";
      shutdown = "sudo shutdown now";
      cekram = "sudo slabtop -o -s -c | bat";
      cleanram = "sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches";

      # Tool overrides
      cat = "bat";
      vi = "nvim";
      py = "python3";
      cd = "z";
      ls = "eza --icons --group-directories-first";
      ll = "eza -lah --git";
      tree = "eza --tree";
      yz = "yazi";
      lg = "lazygit";
      tm = "tmux";

      # Apps
      blue = "bluetui";
      share = "kdeconnect-cli -d ${kdeConnectDeviceId} --share";
      pair_device = "kdeconnect-cli --pair --device ${kdeConnectDeviceId}";
      unpair_device = "kdeconnect-cli --unpair --device ${kdeConnectDeviceId}";
      list_device = "kdeconnect-cli --list-devices";

      # Complex
      vif = "fd --type f --hidden --exclude .git | fzf --preview 'bat --style=numbers --color=always {}' | xargs nvim";
    };
  };
}
