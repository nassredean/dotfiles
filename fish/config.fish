fish_vi_key_bindings
set fish_greeting

set -gx TERM "xterm-256color"

function cat --wraps bat
  bat $argv
end

function vim --wraps nvim
 nvim $argv
end

function fish_paths
  echo $fish_user_paths | tr " " "\n" | nl
end

function fish_remove_path
  set --erase --universal fish_user_paths[$argv[1]]
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

  printf "$pwd"
  printf "%s\n" (__fish_git_prompt)
  printf "$glyph "
end

