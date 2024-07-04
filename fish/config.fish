# Add homebrew to path
eval (/opt/homebrew/bin/brew shellenv)

fish_vi_key_bindings
set fish_greeting

set -gx TERM "xterm-256color"

function cat --wraps bat
  bat $argv
end

function vim --wraps nvim
 nvim $argv
end

function python --wraps python
 python3 $argv
end

function be
  bundle exec $argv
end

function fish_paths
  echo $fish_user_paths | tr " " "\n" | nl
end

function fish_erase_path
  set --erase --universal fish_user_paths[$argv[1]]
end

fish_add_path /Users/nassredean/.local/bin

eval (starship init fish)
