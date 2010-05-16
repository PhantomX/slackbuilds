# Slackware color ls profile script for /bin/sh-like shells.

# Set up LS_OPTIONS environment variable.
# This contains extra command line options to use with ls.
# The default ones are:
#  -F = show '/' for dirs, '*' for executables, etc.
#  -T 0 = don't trust tab spacing when formatting ls output.
#  -b = better support for special characters
OPTIONS="-F -b -T 0"

# COLOR needs one of these arguments:
# 'auto' colorizes output to ttys, but not pipes.
# 'always' adds color characters to all output.
# 'never' shuts colorization off.
COLOR=auto


# This section shouldn't require any user adjustment since it is
# simply setting the LS_OPTIONS variable using the information
# already given above:
LS_OPTIONS="$OPTIONS --color=$COLOR";
export LS_OPTIONS;
unset COLOR
unset OPTIONS

# Set up aliases to use color ls by default.  A few additional
# aliases like 'dir', 'vdir', etc, are some ancient artifacts
# from 1992 or so...  possibly they should be disabled, but maybe
# someone out there is actually using them?  :-)
# Assume shell aliases are supported.
if [ "$SHELL" = "/bin/zsh" ] ; then
  # By default, zsh doesn't split parameters into separate words
  # when it encounters whitespace.  The '=' flag will fix this.
  # see zshexpn(1) man-page regarding SH_WORD_SPLIT.
  alias ls='/bin/ls ${=LS_OPTIONS}'
  alias dir='/bin/ls ${=LS_OPTIONS} --format=vertical'
  alias vdir='/bin/ls ${=LS_OPTIONS} --format=long'
else
  alias ls='/bin/ls $LS_OPTIONS'
  alias dir='/bin/ls $LS_OPTIONS --format=vertical'
  alias vdir='/bin/ls $LS_OPTIONS --format=long'
fi
alias d=dir
alias v=vdir

# Set up the LS_COLORS environment:
if [ -f $HOME/.dir_colors ]; then
  eval `/bin/dircolors -b $HOME/.dir_colors`
elif [ -f /etc/DIR_COLORS ]; then
  eval `/bin/dircolors -b /etc/DIR_COLORS`
else
  eval `/bin/dircolors -b`
fi

