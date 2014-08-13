#!/bin/sh

source "`dirname ${BASH_SOURCE[0]}`/mysql-scripts-common"

# This script waits for mysqld to be ready to accept connections
# (which can be many seconds or even minutes after launch, if there's
# a lot of crash-recovery work to do).
# Running this as ExecStartPost is useful so that services declared as
# "After mysqld" won't be started until the database is really ready.

if [ $# -ne 1 ] ; then
	echo "You need to pass daemon pid as an argument for this script."
	exit 20
fi

# Service file passes us the daemon's PID (actually, mysqld_safe's PID)
daemon_pid="$1"

# Wait for the server to come up or for the mysqld process to disappear
ret=0
while /bin/true; do
	# Check process still exists
	if ! [ -d "/proc/${daemon_pid}" ] ; then
	    ret=1
	    break
	fi
	RESPONSE=`@bindir@/mysqladmin --no-defaults --socket="$socketfile" --user=UNKNOWN_MYSQL_USER ping 2>&1`
	mret=$?
	if [ $mret -eq 0 ] ; then
	    break
	fi
	# exit codes 1, 11 (EXIT_CANNOT_CONNECT_TO_SERVICE) are expected,
	# anything else suggests a configuration error
	if [ $mret -ne 1 -a $mret -ne 11 ]; then
            echo "Cannot check for @NICE_PROJECT_NAME@ Daemon startup because of mysqladmin failure." >&2
	    ret=$mret
	    break
	fi
	# "Access denied" also means the server is alive
	echo "$RESPONSE" | grep -q "Access denied for user" && break

	sleep 1
done

exit $ret
