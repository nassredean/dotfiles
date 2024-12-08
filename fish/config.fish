fish_vi_key_bindings
set fish_greeting

set -gx TERM "xterm-256color"

function cat --wraps bat
  bat $argv
end

function vim --wraps nvim
 nvim $argv
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

# From: https://gist.github.com/tommyip/cf9099fa6053e30247e5d0318de2fb9e
function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
  status --is-command-substitution; and return

  # Check if we are inside a git directory
  if git rev-parse --show-toplevel &>/dev/null
    set gitdir (realpath (git rev-parse --show-toplevel))
    set cwd (pwd -P)
    # While we are still inside the git directory, find the closest
    # virtualenv starting from the current directory.
    while string match "$gitdir*" "$cwd" &>/dev/null
      if test -e "$cwd/.venv/bin/activate.fish"
        source "$cwd/.venv/bin/activate.fish" &>/dev/null
        return
      else
        set cwd (path dirname "$cwd")
      end
    end
  end
  # If virtualenv activated but we are not in a git directory, deactivate.
  if test -n "$VIRTUAL_ENV"
    deactivate
  end
end

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red
set __fish_git_prompt_color_prefix white
set __fish_git_prompt_color_suffix white

function fish_prompt -d "Prints left prompt"
  set -l glyph        "=>"
  set -l glyph_color  (set_color brcyan)
  set -l pwd          (basename (prompt_pwd))
  set -l pwd_color    (set_color bryellow)
  set -l normal_color (set_color normal)
  set -l venv_color   (set_color blue)

  if test (id -u "$USER") -eq 0
      set glyph "#"
  end

  printf "$pwd_color$pwd"
  printf "%s\n" (__fish_git_prompt)
  if test -n "$VIRTUAL_ENV"
      set -l virtualenv (basename "$VIRTUAL_ENV")
      printf "$normal_color($venv_color$virtualenv$normal_color) "
  end
  printf "$glyph_color$glyph $normal_color"
end

function fish_right_prompt -d "Prints right prompt"
  set -l last_status  $status
  set -l stat         "✔️"
  if test "$last_status" -ne 0
      set stat "❌"
  end

  if test $CMD_DURATION
      set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
      printf $duration
  end

  printf " $stat"
end
