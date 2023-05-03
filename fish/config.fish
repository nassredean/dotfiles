# Add homebrew to path
eval (/opt/homebrew/bin/brew shellenv)

fish_vi_key_bindings
set fish_greeting

set -gx HOUFILES /Users/$USER/Library/CloudStorage/Dropbox/APPS/Houdini
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
set -gx HFS /Applications/Houdini/Houdini19.5.569/Frameworks/Houdini.framework/Versions/Current/Resources

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

set -gx PATH $HB $HSB $PATH

set -gx HOUDINI_MAJOR_RELEASE 19
set -gx HOUDINI_MINOR_RELEASE 5
set -gx HOUDINI_BUILD_VERSION 569
set -gx HOUDINI_VERSION "$HOUDINI_MAJOR_RELEASE.$HOUDINI_MINOR_RELEASE.$HOUDINI_BUILD_VERSION"

# Build machine related stuff
set -gx HOUDINI_BUILD_KERNEL "20.6.0"
set -gx HOUDINI_BUILD_PLATFORM "macOS 11.5.2"
set -gx HOUDINI_BUILD_COMPILER "12.0.5.12050022"

eval (starship init fish)
