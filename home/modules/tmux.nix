{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";

    mouse = true;

    prefix = "C-a";

    baseIndex = 1;

    # -------------------------------------------------------
    # Plugins — via Nix, no TPM needed
    # -------------------------------------------------------
    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_window_status_style "rounded"
        '';
      }
    ];

    # -------------------------------------------------------
    # extraConfig
    # -------------------------------------------------------
    extraConfig = ''
      # Terminal RGB
      set -ga terminal-overrides ",*:RGB"

      # Clipboard
      set -g set-clipboard on

      # Split Pane Keys
      unbind %
      unbind '"'
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      # Vim Motion — pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Reload Config
      unbind r
      bind r source-file $HOME/.config/tmux/tmux.conf

      # Alt+hjkl pane navigation
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Pane Resize
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Status Position
      set-option -g status-position top

      # Pane base index + renumber
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # Window switching
      bind -n S-Left previous-window
      bind -n S-Right next-window

      # Alt+number select window
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      # Vim style copy mode
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangular-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      unbind -T copy-mode-vi MouseDragEnd1Pane
    '';
  };
}
