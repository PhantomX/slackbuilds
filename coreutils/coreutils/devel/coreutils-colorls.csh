#! /bin/csh -f
# color-ls initialization
if ( $?USER_LS_COLORS ) then
  if ( "$USER_LS_COLORS" != "" ) then
     #when USER_LS_COLORS defined do not override user 
     #specified LS_COLORS and use them
     goto finish
  endif
endif

alias ll 'ls -l'
alias l. 'ls -d .*'
set COLORS=/etc/DIR_COLORS
if ($?TERM) then
  if ( -e "/etc/DIR_COLORS.$TERM" ) then 
     set COLORS="/etc/DIR_COLORS.$TERM"
  endif
endif
if ( -e "/etc/DIR_COLORS.256color" ) then
  if ( "`tput colors`" == "256" ) then
     set COLORS=/etc/DIR_COLORS.256color
  endif 
endif
if ( -f ~/.dircolors ) set COLORS=~/.dircolors
if ( -f ~/.dir_colors ) set COLORS=~/.dir_colors
if ($?TERM) then
  if ( -f ~/.dircolors."$TERM" ) set COLORS=~/.dircolors."$TERM"
  if ( -f ~/.dir_colors."$TERM" ) set COLORS=~/.dir_colors."$TERM"
endif

if ( ! -e "$COLORS" ) exit

eval `dircolors -c $COLORS`

if ( "$LS_COLORS" == '' ) exit
set color_none=`sed -n '/^COLOR.*none/Ip' < $COLORS`
if ( "$color_none" != '' ) then 
   unset color_none
   exit
endif
unset color_none

finish:
alias ll 'ls -l --color=auto'
alias l. 'ls -d .* --color=auto'
alias ls 'ls --color=auto'
