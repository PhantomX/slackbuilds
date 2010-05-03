# Slackware color ls profile script for /bin/sh-like shells.

# Set up LS_OPTIONS environment variable.
# This contains extra command line options to use with ls.
# The default ones are:
#  -F = show '/' for dirs, '*' for executables, etc.
#  -T 0 = don't trust tab spacing when formatting ls output.
#  -b = better support for special characters
if [ "$SHELL" != "/bin/zsh" ]; then
  # Edit options below for all sh-like shells except zsh:
  OPTIONS="-F -b -T 0"
else
  # If you use zsh, edit the options below instead:
  OPTIONS=( -F -b -T 0 )
fi

# COLOR needs one of these arguments:
# 'auto' colorizes output to ttys, but not pipes.
# 'always' adds color characters to all output.
# 'never' shuts colorization off.
COLOR=auto

# This section shouldn't require any user adjustment since it is
# simply setting the LS_OPTIONS variable using the information
# already given above:
if [ "$SHELL" = "/bin/zsh" ]; then
  LS_OPTIONS=( $OPTIONS --color=$COLOR );
else
  LS_OPTIONS=" $OPTIONS --color=$COLOR ";
fi
export LS_OPTIONS;
unset COLOR
unset OPTIONS

# Set up aliases to use color ls by default.  A few additional
# aliases like 'dir', 'vdir', etc, are some ancient artifacts
# from 1992 or so...  possibly they should be disabled, but maybe
# someone out there is actually using them?  :-)
# Assume shell aliases are supported.  Ash is going to freak out
# when it sees zsh syntax anyway, so whatever.
alias ls='/bin/ls $LS_OPTIONS';
alias dir='/bin/ls $LS_OPTIONS --format=vertical';
alias vdir='/bin/ls $LS_OPTIONS --format=long';
alias d=dir;
alias v=vdir;

# Just for fun, here are the old sh/ash style shell functions.
# this script isn't currently working with ash (and makes some noisy
# error messages), but perhaps these will still be of use to
# someone...
#ls () { /bin/ls $LS_OPTIONS "$@" ; };
#dir () { /bin/ls $LS_OPTIONS --format=vertical "$@" ; };
#vdir () { /bin/ls $LS_OPTIONS --format=long "$@" ; };
#d () { dir "$@" ; };
#v () { vdir "$@" ; };

# Set up the LS_COLORS environment:
if [ -f $HOME/.dir_colors ]; then
  eval `/bin/dircolors -b $HOME/.dir_colors`
elif [ -f /etc/DIR_COLORS ]; then
  eval `/bin/dircolors -b /etc/DIR_COLORS`
else
  eval `/bin/dircolors -b`
fi

