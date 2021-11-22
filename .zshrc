kj:eval $(/opt/homebrew/bin/brew shellenv)

export ZSH="/Users/nassredean/.oh-my-zsh"
export EDITOR=/opt/homebrew/bin/nvim
ZSH_THEME="dracula"

plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

alias ec="$EDITOR $HOME/.zshrc"
alias sc="source $HOME/.zshrc"
alias vim="nvim"
alias cat="bat"

bindkey -v

export GOPATH="$HOME/go"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH=$PATH:/Users/nassredean/workspace/dev-env/bin
export PATH=$PATH:/Users/nassredean/workspace/dotfiles/bin
export PATH=$PATH:/Users/nassredean/go/bin
export PATH="/Users/nassredean/.deno/bin:$PATH"

eval "$(frum init)"
