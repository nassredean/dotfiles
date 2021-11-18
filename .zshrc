eval $(/opt/homebrew/bin/brew shellenv)
# [libpq] PATH update by relay-bootstrap (DO NOT EDIT):
export PATH="/usr/local/opt/libpq/bin:$PATH"
# Add deno to path
export PATH="/Users/nassredean/.deno/bin:$PATH"
# Path to your oh-my-zsh installation.
export ZSH="/Users/nassredean/.oh-my-zsh"

ZSH_THEME="dracula"

plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

export EDITOR=/opt/homebrew/bin/nvim

# open ~/.zshrc in using the default editor specified in $EDITOR
alias ec="$EDITOR $HOME/.zshrc"

# source ~/.zshrc
alias sc="source $HOME/.zshrc"

alias vim="nvim"
alias cat="bat"

bindkey -v

export PATH=$PATH:/Users/nassredean/workspace/dev-env/bin
export PATH=$PATH:/Users/nassredean/workspace/dotfiles/bin

eval "$(frum init)"
