{
  config,
  pkgs,
  lib,
  ...
}:

let
  kdeConnectDeviceId = "ecc1eb827f474ec9af7e269c5dae053a";
in

{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf.historyWidget.fish.command = "";

  catppuccin.fzf = {
    enable = true;
    flavor = "mocha";
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    # Fish has built-in syntax highlighting and autosuggestions.
    # No plugins needed for that — it just works.

    interactiveShellInit = ''
      # Suppress the default fish greeting
      set -g fish_greeting ""

      # Show fastfetch only on local sessions (not SSH)
      if test -z "$SSH_CONNECTION"
        fastfetch
      end

      # Vi mode
      fish_vi_key_bindings
    '';

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

  # Fish doesn't support programs.fish.sessionVariables.
  # Use home.sessionVariables instead — it's universal across all shells.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Fish history is managed internally by fish itself (~/.local/share/fish/fish_history).
  # Atuin will take over history search (Ctrl+R) automatically via enableFishIntegration.
  # No manual history config needed.
}
