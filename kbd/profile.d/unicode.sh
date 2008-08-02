#!/bin/sh
# Unicode fixes

if [ -z "${consoletype}" ]; then
  consoletype=$(/sbin/consoletype)
fi

if [ -n "${LANG}" ]; then
  case ${LANG} in
    *.utf8*|*.UTF-8*)
      if [ "$TERM" = "linux" ]; then
        if [ "$consoletype" = "vt" ]; then
          case ${LANG} in
            ja*) LANG=en_US.UTF-8 ;;
            ko*) LANG=en_US.UTF-8 ;;
            si*) LANG=en_US.UTF-8 ;;
            zh*) LANG=en_US.UTF-8 ;;
            en_IN*) ;;
            *_IN*) LANG=en_US.UTF-8 ;;
          esac
        fi
      fi
      ;;
    *)
      if [ "${TERM}" = "linux" ]; then
        if [ "${consoletype}" = "vt" ]; then
          case ${LANG} in
            ja*) LANG=en_US ;;
            ko*) LANG=en_US ;;
            si*) LANG=en_US ;;
            zh*) LANG=en_US ;;
            en_IN*) ;;
            *_IN*) LANG=en_US ;;
          esac
        fi
      fi
      ;;
  esac
fi
unset consoletype
