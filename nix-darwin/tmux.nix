{ pkgs, ... }:
let
    kanagawa = pkgs.tmuxPlugins.mkTmuxPlugin
    {
        pluginName = "kanagawa";
        version = "unstable-2024-10-09";
        src = pkgs.fetchFromGitHub {
            owner = "Nybkox";
            repo = "tmux-kanagawa";
            rev = "fc95d797ba24536bffe3f2b2101e7d7ec3e5aaa1";
            sha256 = "sha256-vCgqXrT7qukAmx/DUu4H6CT997pdiKOKA0CjLTWEALQ=";
        };
    };
in
{
    programs.tmux = {
        enable = true;
        terminal = "tmux-256-color";
        plugins = with pkgs;
            [
                tmuxPlugins.vim-tmux-navigator
                tmuxPlugins.yank
                tmuxPlugins.sensible
                {
                    plugin = kanagawa;
                    extraConfig = ''
                    set -g @kanagawa-plugins "git battery kubernetes-context cpu-usage ram-usage time"
                    set -g @kanagawa-show-powerline true
                    set -g @kanagawa-day-month true
                    set -g @kanagawa-git-no-repo-message ""
                    set -g @kanagawa-time-format "%F %R"
                    set -g @kanagawa-show-fahrenheit false
                    set -g @kanagawa-kubernetes-eks-hide-arn true
                    set -g @kanagawa-kubernetes-hide-user true
                    # set -g @kanagawa-ignore-window-colors tru
                    '';
                }
            ];
        extraConfig = ''
        set -g default-terminal "screen-256color"
        set -ga terminal-overrides ",xterm-256color:Tc"

        set -g prefix C-a
        unbind C-b
        bind-key C-a send-prefix

        # Rebind opening panes
        unbind %
        bind | split-window -h
        unbind '"'
        bind - split-window -v

        # Refresh tmux conf
        unbind r
        bind r source-file ~/.config.tmux/tmux.conf

        bind -r j resize-pane -D 5
        bind -r k resize-pane -U 5
        bind -r l resize-pane -R 5
        bind -r h resize-pane -L 5

        bind -r m resize-pane -Z


        set -g mouse on

        set-window-option -g mode-keys vi

        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection

        unbind -T copy-mode-vi MouseDragEnd1Pane
        '';
    };
}
