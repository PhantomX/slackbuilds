#!/bin/sh
DEVNAME="$1"
COMMAND="$2"

testwrite() { 
	if touch /var/run/checkrw 2>/dev/null ; then
		rm -rf /var/run/checkrw 
		RW=1
	fi
}

case $DEVNAME in
	eth*|ath*|wlan*|ra*|sta*|ctc*|lcs*|hsi*)
		case $COMMAND in
			'start')
				testwrite

				if [ $RW ]; then
					if [ -x /etc/rc.d/rc.inet1 ]; then
						if ! /sbin/ifconfig | /bin/grep -q "^${DEVNAME} "; then
							/etc/rc.d/rc.inet1 ${DEVNAME}_start
						fi
					fi
					exit 0
				else
					exit 1
				fi
				;;
			'stop')
	                        if [ -x /etc/rc.d/rc.inet1 ]; then
                                     if /sbin/ifconfig | /bin/grep -q "^${DEVNAME} "; then
                                        /etc/rc.d/rc.inet1 ${DEVNAME}_stop
                                     fi
                                fi
                                # Does dhcpcd appear to still be running on the
				# interface?  If so, try to stop it.
                                if [ -r /etc/dhcpc/dhcpcd-$DEVNAME.pid -o -r /var/run/dhcpcd-$DEVNAME.pid ]; then
                                  /sbin/dhcpcd -k -d $DEVNAME
                                  # Force garbage removal, if needed:
                                  if [ -r /etc/dhcpc/dhcpcd-$DEVNAME.pid ]; then
                                     /bin/rm -f /etc/dhcpc/dhcpcd-$DEVNAME.pid
                                  elif [ -r /var/run/dhcpcd-$DEVNAME.pid ]; then
                                     /bin/rm -f /var/run/dhcpcd-$DEVNAME.pid
                                  fi
                                fi
                                # If the interface is now down, exit with a status of 0:
                                if /sbin/ifconfig | /bin/grep -q "^${DEVNAME} " ; then
                                  exit 0
                                fi
                                ;;
			*)
				echo "usage $0 interface start|stop"
				exit 1
				;;
		esac
	;;
	*)
		echo "Interface $DEVNAME not supported."
		exit 1
	;;
esac
exit 0
