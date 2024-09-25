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
export GOPATH='/Users/rickvergunst/go'

# K9s
export XDG_CONFIG_HOME='/Users/rickvergunst/.config'

# Path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:${GOPATH}/bin:/Users/rickvergunst/.cargo/bin

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

eval "$(zoxide init zsh)"

# /Users/rickvergunst/projects/Xccelerated/airbnb/venv/bin:/opt/homebrew/bin:/opt/homebrew/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/Users/rickvergunst/.cargo/bin:/Users/rickvergunst/.nix-profile/bin:/etc/profiles/per-user/rickvergunst/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:/Users/rickvergunst/.local/bin
# /opt/homebrew/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/Users/rickvergunst/.cargo/bin:/Users/rickvergunst/.nix-profile/bin:/etc/profiles/per-user/rickvergunst/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin:/Users/rickvergunst/.local/bin:/usr/local/go/bin

