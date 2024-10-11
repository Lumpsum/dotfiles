{ pkgs, config ,... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initExtra = ''
        # eval "$(oh-my-posh init zsh --config ${config.home.homeDirectory}/.config/ohmyposh/base.toml)"

        eval "$(starship init zsh)"

        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
        [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

        eval "$(zoxide init zsh)"

        source <(fzf --zsh)

        # eval "$(oh-my-posh init zsh)"
        export PYENV_ROOT="$HOME/.pyenv"
        eval "$(pyenv init -)"

        function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                builtin cd -- "$cwd"
            fi
            rm -f -- "$tmp"
        }
        '';

        shellAliases = {
            l = "eza -l --icons --git -a";
            lt = "eza --tree --level=2 --long --icons --git";
            ltree = "eza --tree --level=2  --icons --git";
        };

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
            theme = "robbyrussell";
        };
    };
}
