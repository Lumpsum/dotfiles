# Oh my zsh
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export EDITOR=/opt/homebrew/bin/nvim

# Go
export GOPATH=$HOME/go

# # K9s
# export XDG_CONFIG_HOME='/Users/rickvergunst/.config'

# Kubectl
alias k8s='nvim +"lua require(\"kubectl\").open()"'


# Path
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:${GOPATH}/bin:/Users/rickvergunst/.cargo/bin

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

# Alias
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"

# Fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=/opt/homebrew/bin:$PATH

# Nix
export NIX_CONF_DIR=$HOME/.config/nix
export PATH=/run/current-system/sw/bin:$PATH

# Zoxide
eval "$(zoxide init zsh)"

# Transient prompt
# zle-line-init() {
#   emulate -L zsh
#
#   [[ $CONTEXT == start ]] || return 0
#
#   while true; do
#     zle .recursive-edit
#     local -i ret=$?
#     [[ $ret == 0 && $KEYS == $'\4' ]] || break
#     [[ -o ignore_eof ]] || exit 0
#   done
#
#   local saved_prompt=$PROMPT
#   local saved_rprompt=$RPROMPT
#   PROMPT='%# '
#   RPROMPT=''
#   zle .reset-prompt
#   PROMPT=$saved_prompt
#   RPROMPT=$saved_rprompt
#
#   if (( ret )); then
#     zle .send-break
#   else
#     zle .accept-line
#   fi
#   return ret
# }
#
# zle -N zle-line-init

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
