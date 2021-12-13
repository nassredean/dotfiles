# Add homebrew to path
eval (/opt/homebrew/bin/brew shellenv)

fish_vi_key_bindings

set fish_greeting

set -gx TERM "xterm-256color"
set -gx GOPATH "$HOME/go"
set -gx EDITOR "vim"

fish_add_path "$GOPATH/bin"
fish_add_path "$HOME/workspace/dev-env/bin"
fish_add_path "$HOME/workspace/dotfiles/bin"
fish_add_path "$HOME/go/bin"
fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path "$HOME/.deno/bin"

function cat
  bat $argv
end

function vim
  nvim $argv
end

function _gl --description "print the URL of a file in gitlab"
  argparse --name="_gl" 'c/current' -- $argv

  set -l REMOTE_URL (git remote get-url origin)
  set -l GITLAB_BASE_URL (echo $REMOTE_URL | sed 's/^ssh\:\/\/git\@/https\:\/\//; s/\.git$//; s/\:6767//')

  set -l BRANCH_NAME "master"

  if test $_flag_c
    set BRANCH_NAME (git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  end

  set -l CURRENT_PATH (git rev-parse --show-prefix)

  set -l FILE_PATH $argv[1]

  if test -n $CURRENT_PATH
    set FILE_PATH "$CURRENT_PATH$FILE_PATH"
  end

  if test -z $argv[1]
    echo $GITLAB_BASE_URL
  else
    echo "$GITLAB_BASE_URL/-/blob/$BRANCH_NAME/$FILE_PATH"
  end
end

function glc --description "copy the URL of a file in gitlab"
  argparse --name="_gl" 'c/current' -- $argv

  _gl $_flag_c $argv | pbcopy
end

function glo --description "open the URL of a file in gitlab"
  argparse --name="_gl" 'c/current' -- $argv

  _gl $_flag_c $argv | xargs open
end

eval (starship init fish)
