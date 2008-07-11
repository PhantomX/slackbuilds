#!/bin/sh
#
# Startup script for the fedora.us Thunderbird RPM
# (based on the Mozilla RPM launch script)
#

MOZ_LIB_DIR="/usr/lib"
if [ -x "/usr/lib64/thunderbird-1.5.0.9/thunderbird-bin" ]
then
  MOZ_LIB_DIR="/usr/lib64"
fi

MOZILLA_FIVE_HOME="$MOZ_LIB_DIR/thunderbird-1.5.0.9"
MRE_HOME="$MOZ_LIB_DIR/thunderbird-1.5.0.9"
export MOZILLA_FIVE_HOME MRE_HOME

MOZ_PROGRAM=$MRE_HOME/thunderbird
#MOZ_CLIENT_PROGRAM="$MRE_HOME/mozilla-xremote-client -a thunderbird"
MOZ_CLIENT_PROGRAM="$MRE_HOME/thunderbird -remote"

##
## Set MOZ_ENABLE_PANGO is no longer used because Pango is enabled by default
## you may use MOZ_DISABLE_PANGO=1 to force disabling of pango
##
#MOZ_DISABLE_PANGO=1
#export MOZ_DISABLE_PANGO

# For now, in order to ship with firefox trademarks, we need to default to
# disable pango on non-indic locales.  Use MOZ_ENABLE_PANGO=1 to force pango.
tmplang=${LC_CTYPE:-${LANG:-"en_US.UTF-8"}}
if ! echo $tmplang | grep "^..[_-]IN" > /dev/null; then
   if [ -z "$MOZ_ENABLE_PANGO" ]; then
     MOZ_DISABLE_PANGO=1
     export MOZ_DISABLE_PANGO
   fi
fi


function check_running() {
    $MOZ_CLIENT_PROGRAM 'ping()' 2>/dev/null >/dev/null
    RETURN_VAL=$?
    if [ "$RETURN_VAL" -eq "2" ]; then
      echo 0
      return 0
    else
      echo 1
      return 1
    fi
}

function rm_shit() {
    find $HOME/.thunderbird -name XUL.mfasl 2>/dev/null | xargs rm -f
}

# currently unused
MOZARGS=""

ALREADY_RUNNING=`check_running`

# If no command-line arguments given...
if [ -z "$1" ]; then
    if [ "${ALREADY_RUNNING}" -eq "1" ]; then
        exec $MOZ_CLIENT_PROGRAM "xfeDoCommand(openInbox)" >/dev/null 2>&1
    else
        rm_shit
        exec $MOZ_PROGRAM $MOZARGS >/dev/null 2>&1
    fi
fi

for arg in $@ ; do
    case "$1" in
    -remote)
        shift
        exec $MOZ_PROGRAM -remote "$@"
        ;;

    -mail)
        shift
        if [ "${ALREADY_RUNNING}" -eq "1" ]; then
            # remove 'mailto:' prefix
            ARGS="`echo $@ | sed 's/^mailto://'`"
            exec $MOZ_CLIENT_PROGRAM "mailto($ARGS)"
        else
            rm_shit
            exec $MOZ_PROGRAM $MOZARGS -mail "$@"
        fi
        ;;

    -compose)
        shift
        if [ "${ALREADY_RUNNING}" -eq "1" ]; then
            # remove 'mailto:' prefix
            ARGS="`echo $@ | sed 's/^mailto://'`"
            exec $MOZ_CLIENT_PROGRAM "mailto($ARGS)"
        else
            rm_shit
            exec $MOZ_PROGRAM $MOZARGS -compose "$@"
        fi
        ;;

    *)
        # for now, pass it on and hope for the best
        exec $MOZ_PROGRAM $MOZARGS "$@"
        ;;
    esac
    shift
done

