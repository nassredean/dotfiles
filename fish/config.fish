fish_vi_key_bindings
set fish_greeting

set -gx TERM "xterm-256color"
set -gx EDITOR "nvim"
set -gx FZF_CTRL_T_COMMAND "fd --type f --strip-cwd-prefix" 
set -gx FZF_FIND_FILE_COMMAND "fd --type f --strip-cwd-prefix"
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_COMPLETE 1 

fish_add_path /opt/homebrew/bin
fish_add_path /Users/dean/.local/bin
fish_add_path /usr/local/bin

function cat --wraps bat
  bat -p $argv
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

### Git-prompt settings
set -U __fish_git_prompt_showdirtystate      yes
set -U __fish_git_prompt_showstashstate      yes
set -U __fish_git_prompt_showuntrackedfiles  yes
set -U __fish_git_prompt_showupstream        yes
set -U __fish_git_prompt_color_branch        yellow
set -U __fish_git_prompt_color_upstream_ahead   green
set -U __fish_git_prompt_color_upstream_behind  red
set -U __fish_git_prompt_color_prefix        white
set -U __fish_git_prompt_color_suffix        white

### Suppress Fish’s default vi-mode banner (avoids the extra blank line)
function fish_mode_prompt; end

### Suppress right prompt
function fish_right_prompt; end

function fish_prompt --description 'Compact prompt with hh:mm:ss & git status'
    set -l last_status $status

    # colours
    set -l yellow (set_color bryellow)
    set -l cyan   (set_color brcyan)
    set -l green  (set_color brgreen)
    set -l red    (set_color brred)
    set -l normal (set_color normal)

    # segments
    set -l ts  (date '+%H:%M:%S')
    set -l dir (prompt_pwd --dir-length=1)

    # git: prepend one space only if we’re inside a repo
    set -l git_segment ''
    set -l git (__fish_git_prompt)
    if test -n "$git"
        set git_segment " $git"
    end

    set -l exit  (test $last_status -eq 0; and echo "$green✔$normal"; or echo "$red✗$normal")
    set -l glyph (test (id -u) -eq 0; and echo '#'; or echo '➜')

    #            colour [time]   space colour dir reset git    space exit space glyph space
    printf '%s[%s] %s%s%s%s %s %s ' \
        $yellow $ts \
        $cyan   $dir $normal "$git_segment" \
        $exit \
        $glyph
end 

fzf --fish | source

