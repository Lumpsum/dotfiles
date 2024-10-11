{ pkgs, ... }:
{
    programs.wezterm = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        extraConfig = ''
            local config = wezterm.config_builder()

            config.font_size = 16.0
            config.hide_tab_bar_if_only_one_tab = true
            config.default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" }

            config.front_end = "WebGpu"

            return config
        '';
      };
}
