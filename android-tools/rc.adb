#!/bin/sh
#
# description: Android Debug Bridge
# processname: adb
# Short-Description: Android Debug Bridge

exec="/usr/bin/adb"
prog=$(basename ${exec})
lockfile=/var/lock/subsys/${prog}

[ -x "${exec}" ] || exit 0

RETVAL=0

PID=$(/sbin/pidof -o %PPID ${exec})

start() {
  echo -n "Starting ${prog}: "
  if [ -z "${PID}" ] ;then 
    ${exec} start-server &>/dev/null
    RETVAL=$?
  else
    RETVAL=1
  fi
  if [ ${RETVAL} -eq 0 ] && touch ${lockfile} ; then
    echo -e "\t\t\t\t\t\t[  OK  ]\r"
  else
    echo -e "\t\t\t\t\t\t[FAILED]\r"
  fi
  return ${RETVAL}
}

stop() {
  echo -n "Stopping ${prog}: "
  if [ -n "${PID}" ] ;then
    ${exec} kill-server &>/dev/null
    RETVAL=$?
  else
    RETVAL=1
  fi
  if [ ${RETVAL} -eq 0 ] && rm -f ${lockfile} ; then
    echo -e "\t\t\t\t\t\t[  OK  ]\r"
  else
    echo -e "\t\t\t\t\t\t[FAILED]\r"
  fi
  return ${RETVAL}
}

restart() {
  stop
  unset PID
  sleep 1
  start
}

status() {
  if [ -n "${PID}" ] ;then
    echo "${prog} is running in pid ${PID}."
  else
    echo "${prog} is not running."
    RETVAL=3
  fi
  return ${RETVAL}
}

condrestart(){
  [ -e ${lockfile} ] && restart
  return 0
}

# See how we were called.
case "$1" in
  start|stop|restart|status|condrestart)
    $1
    ;;
  force-reload|reload)
    restart
    ;;
  *)
    echo "Usage: $0 {start|stop|status|restart|condrestart|reload|force-reload}"
    exit 2
    ;;
esac

exit ${RETVAL}
