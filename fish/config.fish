# Add homebrew to path
eval (/opt/homebrew/bin/brew shellenv)

fish_vi_key_bindings
set fish_greeting

set -gx TERM "xterm-256color"
set -gx GOPATH "$HOME/go"
fish_add_path "$GOPATH/bin"
fish_add_path "$HOME/neovim/bin"

function vim --wraps nvim
  nvim $argv
end

function cat --wraps bat
  bat $argv
end

eval (starship init fish)
