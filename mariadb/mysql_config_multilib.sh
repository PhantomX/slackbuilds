#! /bin/sh
#
# Wrapper script for mysql_config to support multilib
#
# This command respects setarch

host=$(uname -m)

case "${host}" in
  s390x|x86_64)
    if [ -x @bindir@/mysql_config-64 ] ; then
      @bindir@/mysql_config-64 "$@"
    else
      @bindir@/mysql_config "$@"
    fi
    ;;
  *)
    if [ -x @bindir@/mysql_config-32 ] ; then
      @bindir@/mysql_config-32 "$@"
    else
      @bindir@/mysql_config "$@"
    fi
    ;;
esac

