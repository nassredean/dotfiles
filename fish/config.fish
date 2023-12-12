# Add homebrew to path
eval (/opt/homebrew/bin/brew shellenv)

fish_vi_key_bindings
set fish_greeting

set -gx TERM "xterm-256color"

function vim --wraps nvim
  nvim $argv
end

function cat --wraps bat
  bat $argv
end

function python --wraps python
 python3 $argv
end

function be
  bundle exec $argv
end

eval (starship init fish)

fish_add_path /Users/nassredean/workspace/zig/build/stage3/bin
fish_add_path /Users/nassredean/workspace/zls/zig-out/bin

#
#   Environment setup for Houdini.
#
#   Note that this function modifies your search path by inserting the
#   Houdini bin directory at the beginning. It also explicitly sets
#   the environment variable LD_LIBRARY_PATH which is used to
#   search for runtime libraries.
#
#   To run the function in quiet mode, specify the "-q" option as an argument.
#
set -gx HFS /Applications/Houdini/Houdini20.0.547/Frameworks/Houdini.framework/Versions/Current/Resources

#
#  The following are some handy shortcuts:
#
set -gx H $HFS
set -gx HB $H/bin
set -gx HDSO $H/../Libraries
set -gx HH $H/houdini
set -gx HHC $HH/config
set -gx HHP $HH/python3.9libs
set -gx HT $H/toolkit
set -gx HSB $HH/sbin

#
#  The following is used as the generic /tmp path.  This is also
# set on Windows to the temporary directory, so can be used for
# system independent .hip files.
#
set -gx TEMP /tmp

# set -gx PATH $HB $HSB $PATH
fish_add_path $HB
fish_add_path $HSB

set -gx HOUDINI_MAJOR_RELEASE 20
set -gx HOUDINI_MINOR_RELEASE 0
set -gx HOUDINI_BUILD_VERSION 547
set -gx HOUDINI_VERSION "$HOUDINI_MAJOR_RELEASE.$HOUDINI_MINOR_RELEASE.$HOUDINI_BUILD_VERSION"

# Build machine related stuff
set -gx HOUDINI_BUILD_KERNEL "22.4.0"
set -gx HOUDINI_BUILD_PLATFORM "macOS 13.3.1"
set -gx HOUDINI_BUILD_COMPILER "14.0.0.14000029"


# Created by `pipx` on 2023-11-16 17:03:25
set PATH $PATH /Users/nassredean/.local/bin
