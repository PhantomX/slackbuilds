#!/bin/bash
#
#/etc/rc.d/init.d/speech-dispatcherd
# Author: Hemant Goyal <goyal.hemant@gmail.com>
#
# chkconfig: - 13 87
# description: provides a high-level device independent layer for speech synthesis

exec="/usr/bin/speech-dispatcher"
prog=$(basename ${exec})
config="/etc/speech-dispatcher/speechd.conf"
lockfile=/var/lock/subsys/${prog}

RETVAL=0

PID=$(/sbin/pidof -o %PPID ${exec})

start() {
  [ -x "${exec}" ] || exit 0
  [ -f "${config}" ]  || exit 6
  echo -n "Starting ${prog}: "
  if [ -z "${PID}" ] ;then 
   ${exec} -d -p ${lockfile} 2>&1 | logger -i
    RETVAL=$?
  else
    RETVAL=1
  fi
  if [ ${RETVAL} -eq 0 ] && touch ${lockfile} ; then
    echo -e "\t\t\t\t\t[  OK  ]\r"
  else
    echo -e "\t\t\t\t\t[FAILED]\r"
  fi
  return ${RETVAL}
}

stop() {
  echo -n "Stopping ${prog}: "
  if [ -n "${PID}" ] ;then
    kill ${PID} &>/dev/null
    RETVAL=$?
  else
    RETVAL=1
  fi
  if [ ${RETVAL} -eq 0 ] && rm -f ${lockfile} ; then
    echo -e "\t\t\t\t\t[  OK  ]\r"
  else
    echo -e "\t\t\t\t\t[FAILED]\r"
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
  if [ -f ${lockfile} ]; then
    echo "${prog} is running in pid ${PID}."
  else
    echo "${prog} is not running."
  fi
}

case "$1" in
  start|stop|status)
    $1
    ;;
  force-reload|restart|reload)
    restart
    ;;
  condrestart)
    if  [ ! -f ${lockfile} ]; then restart ;fi
    ;;
  *)
    echo "Usage: $0 {start|stop|status|restart|condrestart|reload|force-reload}"
    exit 2
    ;;
esac
