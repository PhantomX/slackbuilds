#!/bin/sh
#
# Copyright 1998 VMware, Inc.  All rights reserved.
#
# This script manages the services needed to run VMware software
#

# Basic support for IRIX style chkconfig
###
# chkconfig: 235 19 08
# description: Manages the services needed to run VMware software
###

# Basic support for the Linux Standard Base Specification 1.3
# Used by insserv and other LSB compliant tools.
### BEGIN INIT INFO
# Provides: VMware
# Required-Start: $network $syslog
# Required-Stop:
# Default-Start: 2 3 5
# Default-Stop: 0 6
# Short-Description: Manages the services needed to run VMware software
# Description: Manages the services needed to run VMware software
### END INIT INFO

# BEGINNING_OF_UTIL_DOT_SH
#!/bin/sh

# A few utility functions used by our shell scripts. These are patched in during
# make.


# They are a lot of small utility programs to create temporary files in a
# secure way, but none of them is standard. So I wrote this --hpreg
make_tmp_dir() {
  local dirname="$1" # OUT
  local prefix="$2"  # IN
  local tmp
  local serial
  local loop

  tmp="${TMPDIR:-/tmp}"

  # Don't overwrite existing user data
  # -> Create a directory with a name that didn't exist before
  #
  # This may never succeed (if we are racing with a malicious process), but at
  # least it is secure
  serial=0
  loop='yes'
  while [ "$loop" = 'yes' ]; do
    # Check the validity of the temporary directory. We do this in the loop
    # because it can change over time
    if [ ! -d "$tmp" ]; then
      echo 'Error: "'"$tmp"'" is not a directory.'
      echo
      exit 1
    fi
    if [ ! -w "$tmp" -o ! -x "$tmp" ]; then
      echo 'Error: "'"$tmp"'" should be writable and executable.'
      echo
      exit 1
    fi

    # Be secure
    # -> Don't give write access to other users (so that they can not use this
    # directory to launch a symlink attack)
    if mkdir -m 0755 "$tmp"'/'"$prefix$serial" >/dev/null 2>&1; then
      loop='no'
    else
      serial=$(($serial + 1))
      if [ "$(($serial % 200))" = '0' ]; then
        echo 'Warning: The "'"$tmp"'" directory may be under attack.'
        echo
      fi
    fi
  done

  eval "$dirname"'="$tmp"'"'"'/'"'"'"$prefix$serial"'
}

# Check if the process associated to a pidfile is running.
# Return 0 if the pidfile exists and the process is running, 1 otherwise
vmware_check_pidfile() {
  local pidfile="$1" # IN
  local pid

  pid=`cat "$pidfile" 2>/dev/null`
  if [ "$pid" = '' ]; then
    # The file probably does not exist or is empty. Failure
    return 1
  fi
  # Keep only the first number we find, because some Samba pid files are really
  # trashy: they end with NUL characters
  # There is no double quote around $pid on purpose
  set -- $pid
  pid="$1"

  [ -d /proc/"$pid" ]

}

# Note:
#  . Each daemon must be started from its own directory to avoid busy devices
#  . Each PID file doesn't need to be added to the installer database, because
#    it is going to be automatically removed when it becomes stale (after a
#    reboot). It must go directly under /var/run, or some distributions
#    (RedHat 6.0) won't clean it
#

# Terminate a process synchronously
vmware_synchrone_kill() {
   local pid="$1"    # IN
   local signal="$2" # IN
   local second

   kill -"$signal" "$pid"

   # Wait a bit to see if the dirty job has really been done
   for second in 0 1 2 3 4 5 6 7 8 9 10; do
      if [ ! -d /proc/"$pid" ]; then
         # Success
         return 0
      fi

      sleep 1
   done

   # Timeout
   return 1
}

# Kill the process associated to a pidfile
vmware_stop_pidfile() {
   local pidfile="$1" # IN
   local pid

   pid=`cat "$pidfile" 2>/dev/null`
   if [ "$pid" = '' ]; then
      # The file probably does not exist or is empty. Success
      return 0
   fi
   # Keep only the first number we find, because some Samba pid files are really
   # trashy: they end with NUL characters
   # There is no double quote around $pid on purpose
   set -- $pid
   pid="$1"

   # First try a nice SIGTERM
   if vmware_synchrone_kill "$pid" 15; then
      return 0
   fi

   # Then send a strong SIGKILL
   if vmware_synchrone_kill "$pid" 9; then
      return 0
   fi

   return 1
}

# END_OF_UTIL_DOT_SH

vmware_etc_dir=/etc/vmware
serverd=vmware-serverd

# Since this script is installed, our main database should be installed too and
# should contain the basic information
vmware_db="$vmware_etc_dir"/locations
if [ ! -r "$vmware_db" ]; then
   echo 'Warning: Unable to find '"`vmware_product_name`""'"'s main database '"$vmware_db"'.'
   echo

   exit 1
fi

# BEGINNING_OF_DB_DOT_SH
#!/bin/sh

#
# Manage an installer database
#

# Add an answer to a database in memory
db_answer_add() {
  local dbvar="$1" # IN/OUT
  local id="$2"    # IN
  local value="$3" # IN
  local answers
  local i

  eval "$dbvar"'_answer_'"$id"'="$value"'

  eval 'answers="$'"$dbvar"'_answers"'
  # There is no double quote around $answers on purpose
  for i in $answers; do
    if [ "$i" = "$id" ]; then
      return
    fi
  done
  answers="$answers"' '"$id"
  eval "$dbvar"'_answers="$answers"'
}

# Remove an answer from a database in memory
db_answer_remove() {
  local dbvar="$1" # IN/OUT
  local id="$2"    # IN
  local new_answers
  local answers
  local i

  eval 'unset '"$dbvar"'_answer_'"$id"

  new_answers=''
  eval 'answers="$'"$dbvar"'_answers"'
  # There is no double quote around $answers on purpose
  for i in $answers; do
    if [ "$i" != "$id" ]; then
      new_answers="$new_answers"' '"$i"
    fi
  done
  eval "$dbvar"'_answers="$new_answers"'
}

# Load all answers from a database on stdin to memory (<dbvar>_answer_*
# variables)
db_load_from_stdin() {
  local dbvar="$1" # OUT

  eval "$dbvar"'_answers=""'

  # read doesn't support -r on FreeBSD 3.x. For this reason, the following line
  # is patched to remove the -r in case of FreeBSD tools build. So don't make
  # changes to it. -- Jeremy Bar
  while read -r action p1 p2; do
    if [ "$action" = 'answer' ]; then
      db_answer_add "$dbvar" "$p1" "$p2"
    elif [ "$action" = 'remove_answer' ]; then
      db_answer_remove "$dbvar" "$p1"
    fi
  done
}

# Load all answers from a database on disk to memory (<dbvar>_answer_*
# variables)
db_load() {
  local dbvar="$1"  # OUT
  local dbfile="$2" # IN

  db_load_from_stdin "$dbvar" < "$dbfile"
}

# Iterate through all answers in a database in memory, calling <func> with
# id/value pairs and the remaining arguments to this function
db_iterate() {
  local dbvar="$1" # IN
  local func="$2"  # IN
  shift 2
  local answers
  local i
  local value

  eval 'answers="$'"$dbvar"'_answers"'
  # There is no double quote around $answers on purpose
  for i in $answers; do
    eval 'value="$'"$dbvar"'_answer_'"$i"'"'
    "$func" "$i" "$value" "$@"
  done
}

# If it exists in memory, remove an answer from a database (disk and memory)
db_remove_answer() {
  local dbvar="$1"  # IN/OUT
  local dbfile="$2" # IN
  local id="$3"     # IN
  local answers
  local i

  eval 'answers="$'"$dbvar"'_answers"'
  # There is no double quote around $answers on purpose
  for i in $answers; do
    if [ "$i" = "$id" ]; then
      echo 'remove_answer '"$id" >> "$dbfile"
      db_answer_remove "$dbvar" "$id"
      return
    fi
  done
}

# Add an answer to a database (disk and memory)
db_add_answer() {
  local dbvar="$1"  # IN/OUT
  local dbfile="$2" # IN
  local id="$3"     # IN
  local value="$4"  # IN

  db_remove_answer "$dbvar" "$dbfile" "$id"
  echo 'answer '"$id"' '"$value" >> "$dbfile"
  db_answer_add "$dbvar" "$id" "$value"
}

# Add a file to a database on disk
# 'file' is the file to put in the database (it may not exist on the disk)
# 'tsfile' is the file to get the timestamp from, '' if no timestamp
db_add_file() {
  local dbfile="$1" # IN
  local file="$2"   # IN
  local tsfile="$3" # IN
  local date

  if [ "$tsfile" = '' ]; then
    echo 'file '"$file" >> "$dbfile"
  else
    date=`date -r "$tsfile" '+%s' 2> /dev/null`
    if [ "$date" != '' ]; then
      date=' '"$date"
    fi
    echo 'file '"$file$date" >> "$dbfile"
  fi
}

# Add a directory to a database on disk
db_add_dir() {
  local dbfile="$1" # IN
  local dir="$2"    # IN

  echo 'directory '"$dir" >> "$dbfile"
}
# END_OF_DB_DOT_SH

db_load 'vmdb' "$vmware_db"

if [ "%PACKAGERVERSION%" = "2" ]; then
   vmdb_answer_VNET_0_INTERFACE="$vmdb_answer_VNET_INTERFACE"
   vmdb_answer_VNET_1_HOSTONLY_HOSTADDR="$vmdb_answer_VNET_HOSTONLY_HOSTADDR"
   vmdb_answer_VNET_1_HOSTONLY_NETMASK="$vmdb_answer_VNET_HOSTONLY_NETMASK"
   vmdb_answer_VNET_1_SAMBA="$vmdb_answer_VNET_SAMBA"
fi

# This comment is a hack to prevent RedHat distributions from outputing
# "Starting <basename of this script>" when running this startup script.
# We just need to write the word daemon followed by a space --hpreg.

# This defines echo_success() and echo_failure() on RedHat
if [ -r "$vmdb_answer_INITSCRIPTSDIR"'/functions' ]; then
   . "$vmdb_answer_INITSCRIPTSDIR"'/functions'
fi

# This defines $rc_done and $rc_failed on S.u.S.E.
if [ -f /etc/rc.config ]; then
   # Don't include the entire file: there could be conflicts
   rc_done=`(. /etc/rc.config; echo "$rc_done")`
   rc_failed=`(. /etc/rc.config; echo "$rc_failed")`
else
   # Make sure the ESC byte is literal: Ash does not support echo -e
   rc_done='[71G done'
   rc_failed='[71Gfailed'
fi

subsys=vmware
driver=vmmon
ppuser=vmppuser
vnet=vmnet
bridge=vmnet-bridge
dhcpd=vmnet-dhcpd
netifup=vmnet-netifup
natd=vmnet-natd
ping=vmware-ping
smbd=vmware-smbd
nmbd=vmware-nmbd

#
# Utilities
#

# BEGINNING_OF_IPV4_DOT_SH
#!/bin/sh

#
# IPv4 address functions
#
# Thanks to Owen DeLong <owen@delong.com> for pointing me at bash's arithmetic
# expansion ability, which is a lot faster than using 'expr' --hpreg
#

# Compute the subnet address associated to a couple IP/netmask
ipv4_subnet() {
  local ip="$1"
  local netmask="$2"

  # Split quad-dotted addresses into bytes
  # There is no double quote around the back-quoted expression on purpose
  # There is no double quote around $ip and $netmask on purpose
  set -- `IFS='.'; echo $ip $netmask`

  echo $(($1 & $5)).$(($2 & $6)).$(($3 & $7)).$(($4 & $8))
}

# Compute the broadcast address associated to a couple IP/netmask
ipv4_broadcast() {
  local ip="$1"
  local netmask="$2"

  # Split quad-dotted addresses into bytes
  # There is no double quote around the back-quoted expression on purpose
  # There is no double quote around $ip and $netmask on purpose
  set -- `IFS='.'; echo $ip $netmask`

  echo $(($1 | (255 - $5))).$(($2 | (255 - $6))).$(($3 | (255 - $7))).$(($4 | (255 - $8)))
}
# END_OF_IPV4_DOT_SH

# Are we running in a VM?
vmware_inVM() {
   "$vmware_etc_dir"/checkvm >/dev/null 2>&1
}

# Returns the specific VMware product
vmware_product() {
   echo '%SHORTNAME%'
   exit 0
}

# This is a function in case a future product name contains language-specific
# escape characters.
vmware_product_name() {
   echo '%LONGNAME%'
   exit 0
}

#
# Report the number of references to the $driver module.
# Used to figure out if there are any VMs running.
#
vmmonUseCount() {
   # Beware of module dependancies here. An exact match is important
   /sbin/lsmod | awk 'BEGIN {n = 0;} {if ($1 == "'"$driver"'") n = $3;} END {print n;}'
}

# Is a given module loaded?
isLoaded() {
   local module="$1"

   /sbin/lsmod | awk 'BEGIN {n = "no";} {if ($1 == "'"$module"'") n = "yes";} END {print n;}'
}

# Check if there is an IP route for a given subnet via a given interface
# Return true if there is _NO_ such route
noRoutePresent() {
   local subnet="$1" # IN
   local intf="$2"   # IN

   # Beware, there may be several identical routes
   [ "`/sbin/route -n | grep '^'"$subnet"'.*'"$intf"'$'`" = '' ]
}

#
# Check that the IP address we are going to assign to the host machine on
# a private IP network does not already exist
#
# NB: If you don't want to do this test, just substitute
#     false for it.
#
lookForHostOnlyNetwork() {
   local ip="$1"

   "$vmdb_answer_BINDIR"/"$ping" -q "$ip"
}

# Build a Linux kernel integer version
kernel_version_integer() {
   echo $(((($1 * 256) + $2) * 256 + $3))
}

# Get the running kernel integer version
get_version_integer() {
   local version_uts
   local v1
   local v2
   local v3

   version_uts=`uname -r`

   # There is no double quote around the back-quoted expression on purpose
   # There is no double quote around $version_uts on purpose
   set -- `IFS='.'; echo $version_uts`
   v1="$1"
   v2="$2"
   v3="$3"
   # There is no double quote around the back-quoted expression on purpose
   # There is no double quote around $v3 on purpose
   set -- `IFS='-ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz'; echo $v3`
   v3="$1"

   kernel_version_integer "$v1" "$v2" "$v3"
}

# Do we need the ppuser module?
isPpuserNeeded() {
   local version_integer

   version_integer=`get_version_integer`
   echo $(((`kernel_version_integer '2' '1' '127'` <= $version_integer) && ($version_integer <= `kernel_version_integer '2' '3' '9'`)))
}

vmware_failed() {
   if [ "`type -t 'echo_failure' 2>/dev/null`" = 'function' ]; then
      echo_failure
   else
      echo -n "$rc_failed"
   fi
}

vmware_success() {
   if [ "`type -t 'echo_success' 2>/dev/null`" = 'function' ]; then
      echo_success
   else
      echo -n "$rc_done"
   fi
}

# Execute a macro
vmware_exec() {
   local msg="$1"  # IN
   local func="$2" # IN
   shift 2

   echo -n '   '"$msg"

   # On Caldera 2.2, SIGHUP is sent to all our children when this script exits
   # I wanted to use shopt -u huponexit instead but their bash version
   # 1.14.7(1) is too old
   #
   # Ksh does not recognize the SIG prefix in front of a signal name
   if [ "$VMWARE_DEBUG" = 'yes' ]; then
      (trap '' HUP; "$func" "$@")
   else
      (trap '' HUP; "$func" "$@") >/dev/null 2>&1
   fi
   if [ "$?" -gt 0 ]; then
      vmware_failed
      echo
      return 1
   fi

   vmware_success
   echo
   return 0
}

# Execute a macro in the background
vmware_bg_exec() {
   local msg="$1"  # IN
   local func="$2" # IN
   shift 2

   if [ "$VMWARE_DEBUG" = 'yes' ]; then
      # Force synchronism when debugging
      vmware_exec "$msg" "$func" "$@"
   else
      echo -n '   '"$msg"' (background)'

      # On Caldera 2.2, SIGHUP is sent to all our children when this script exits
      # I wanted to use shopt -u huponexit instead but their bash version
      # 1.14.7(1) is too old
      #
      # Ksh does not recognize the SIG prefix in front of a signal name
      (trap '' HUP; "$func" "$@") 2>&1 | logger -t 'VMware[init]' -p daemon.err &

      vmware_success
      echo
      return 0
   fi
}

vmware_load_module() {
   /sbin/insmod -s -f "/lib/modules/`uname -r`/misc/$1.o" || exit 1
   exit 0
}

vmware_unload_module() {
   if [ "`isLoaded "$1"`" = 'yes' ]; then
      /sbin/rmmod "$1" || exit 1
   fi
   exit 0
}

# Start the virtual machine monitor kernel service
vmware_start_vmmon() {
   vmware_load_module $driver
}

# Stop the virtual machine monitor kernel service
vmware_stop_vmmon() {
   vmware_unload_module $driver
}

# Start the virtual machine parallel port kernel service
vmware_start_vmppuser() {
   if ! grep -q ' parport_release[^'$'\t'']*$' /proc/ksyms; then
      # parport support is not built in the kernel
      /sbin/modprobe parport || exit 1
   fi
   if ! grep -q ' parport_pc_[^'$'\t'']*$' /proc/ksyms; then
      # parport_pc support is not built in the kernel
      /sbin/modprobe parport_pc || exit 1
   fi
   vmware_load_module $ppuser
}

# Stop the virtual machine parallel port kernel service
vmware_stop_vmppuser() {
   if [ "`isLoaded "$ppuser"`" = 'yes' ]; then
      /sbin/rmmod "$ppuser" || exit 1
   fi
   # Try to unload the modules. Failure is allowed because some other process
   # could be using them.
   /sbin/modprobe -r parport_pc
   /sbin/modprobe -r parport

   # Return the right exitcode even if the previous commands failed
   exit 0
}

# Start the virtual ethernet kernel service
vmware_start_vmnet() {
   vmware_load_module $vnet
}

# Stop the virtual ethernet kernel service
vmware_stop_vmnet() {
   vmware_unload_module $vnet
}

# Create /dev/vmnetXX device
vmware_create_vmnet() {
   local vHubNr="$1" # IN
   local vDevice="/dev/vmnet$vHubNr"

   if [ ! -e "$vDevice" ]; then
      mknod -m 600 "$vDevice" c 119 "$vHubNr"
   fi
}

# Create a virtual host ethernet interface and connect it to a virtual
# ethernet hub
vmware_start_netifup() {
   local vHostIf="$1" # IN
   local vHubNr="$2"  # IN

   cd "$vmdb_answer_BINDIR" && "$vmdb_answer_BINDIR"/"$netifup" \
      -d /var/run/"$netifup"-"$vHostIf".pid /dev/vmnet"$vHubNr" "$vHostIf"
}

# Disconnect a virtual host ethernet interface from a virtual ethernet hub
# and destroy the virtual host ethernet interface
vmware_stop_netifup() {
   local vHostIf="$1" # IN

   if vmware_stop_pidfile /var/run/"$netifup"-"$vHostIf".pid; then
      rm -f /var/run/"$netifup"-"$vHostIf".pid
   fi
}

# Connect a physical host ethernet interface to a virtual ethernet hub
vmware_start_bridge() {
   local vHubNr="$1"  # IN
   local pHostIf="$2" # IN

   cd "$vmdb_answer_BINDIR" && "$vmdb_answer_BINDIR"/"$bridge" \
      -d /var/run/"$bridge"-"$vHubNr".pid /dev/vmnet"$vHubNr" "$pHostIf"
}

# Disconnect a physical host ethernet interface from a virtual ethernet hub
vmware_stop_bridge() {
   local vHubNr="$1"  # IN

   if vmware_stop_pidfile /var/run/"$bridge"-"$vHubNr".pid; then
      rm -f /var/run/"$bridge"-"$vHubNr".pid
   fi
}

# Start a SMB name server on a private IP network
vmware_start_nmbd() {
   local vHostIf="$1" # IN

   # Disable logging to avoid the uncontrolled creation of unmanaged files
   cd "$vmdb_answer_BINDIR" && "$vmdb_answer_BINDIR"/"$nmbd" -D -l /dev/null \
      -s "$vmware_etc_dir"/"$vHostIf"/smb/smb.conf \
      -f /var/run/"$nmbd"-"$vHostIf".pid
}

# Stop a SMB name server on a private IP network
vmware_stop_nmbd() {
   local vHostIf="$1" # IN

   if vmware_stop_pidfile /var/run/"$nmbd"-"$vHostIf".pid; then
      rm -f /var/run/"$nmbd"-"$vHostIf".pid
   fi
}

# Start a SMB share server on a private IP network
vmware_start_smbd() {
   local vHostIf="$1" # IN

   # Disable logging to avoid the uncontrolled creation of unmanaged files
   cd "$vmdb_answer_BINDIR" && "$vmdb_answer_BINDIR"/"$smbd" -D -l /dev/null \
      -s "$vmware_etc_dir"/"$vHostIf"/smb/smb.conf \
      -f /var/run/"$smbd"-"$vHostIf".pid
}

# Stop a SMB share server on a private IP network
vmware_stop_smbd() {
   local vHostIf="$1" # IN

   if vmware_stop_pidfile /var/run/"$smbd"-"$vHostIf".pid; then
      rm -f /var/run/"$smbd"-"$vHostIf".pid
   fi
}

# Start a DHCP server on a private IP network
vmware_start_dhcpd() {
   local vHostIf="$1" # IN

   # The daemon already logs its output in the system log, so we can safely
   # trash it
   cd "$vmdb_answer_BINDIR" && "$vmdb_answer_BINDIR"/"$dhcpd" \
      -cf "$vmware_etc_dir"/"$vHostIf"/dhcpd/dhcpd.conf \
      -lf "$vmware_etc_dir"/"$vHostIf"/dhcpd/dhcpd.leases \
      -pf /var/run/"$dhcpd"-"$vHostIf".pid "$vHostIf" >/dev/null 2>&1
}

# Stop a DHCP server on a private IP network
vmware_stop_dhcpd() {
   local vHostIf="$1" # IN

   if vmware_stop_pidfile /var/run/"$dhcpd"-"$vHostIf".pid; then
      rm -f /var/run/"$dhcpd"-"$vHostIf".pid
   fi
}

# Start the host-only network user service
vmware_start_hostonly() {
   local vHubNr="$1"    # IN
   local vHostIf="$2"   # IN
   local ifIp="$3"      # IN
   local ifMask="$4"    # IN
   local run_dhcpd="$5" # IN
   local run_samba="$6" # IN
   local ifNet

   #
   # Do a cursory check to see if the host-only network
   # configuration is still ok.  We do this so that mobile
   # hosts don't get setup at install time and then moved to
   # a new locale where the host-only network config is no
   # longer valid.
   #
   # NB: This really needs to be done at power-on time when
   #     VM is configured to use host-only networking so that
   #     we aren't fooled by dynamic changes in the network.
   #
   # XXX ping takes 10 seconds to timeout if nobody answers
   #     that slows boot too much so we do this bit in the
   #     background.
   #
   if lookForHostOnlyNetwork "$ifIp"; then
    echo 'Host-only networking disabled because '"$ifIp"
    echo 'appears to be a real, physical, existing address.'
    echo 'Please run "'"$vmdb_answer_BINDIR"'/vmware-config.pl" to'
    echo 'modify your host-only network configuration.'
    exit 1
   fi

   vmware_start_netifup "$vHostIf" "$vHubNr" || exit 1

   # Configure the virtual host ethernet interface and define the private IP
   # network
   #
   # . We provide the broadcast address explicitly because versions of ifconfig
   #   prior to 1.39 (1999-03-18) seem to miscompute it
   # . 2.0.x kernels don't install a route when the interface is marked up, but
   #   2.2.x kernel do. Since we want to see any errors from route we don't
   #   just discard messages from route, but instead check if the route got
   #   installed before manually adding one.
   ifNet=`ipv4_subnet "$ifIp" "$ifMask"`
   if ifconfig "$vHostIf" inet "$ifIp" netmask "$ifMask" \
         broadcast "`ipv4_broadcast "$ifIp" "$ifMask"`" up \
         && noRoutePresent "$ifNet" "$vHostIf"; then
      route add -net "$ifNet" netmask "$ifMask" "$vHostIf"
   fi

   if [ "$run_dhcpd" = 'yes' ]; then
      vmware_start_dhcpd "$vHostIf" || exit 1
   fi

   if [ "$run_samba" = 'yes' ]; then
      vmware_start_nmbd "$vHostIf" || exit 1
      vmware_start_smbd "$vHostIf" || exit 1
   fi

   exit 0
}

# Stop the host-only network user service
vmware_stop_hostonly() {
   local vHostIf="$1"   # IN
   local ifIp="$2"      # IN
   local ifMask="$3"    # IN
   local ifNet

   # Terminate the private network
   ifNet=`ipv4_subnet "$ifIp" "$ifMask"`
   noRoutePresent "$ifNet" "$vHostIf" || \
      route del -net "$ifNet" netmask "$ifMask" || exit 1
   # To test if the interface exists, we can not just look at the exitcode
   # because old versions of ifconfig don't exit with 1 when invoked with a
   # non-existing interface
   if [ "`ifconfig "$vHostIf" 2>/dev/null`" != '' ]; then
      ifconfig "$vHostIf" down || exit 1
   fi

   vmware_stop_netifup "$vHostIf" || exit 1

   exit 0
}

# Start the NAT network user service
vmware_start_nat() {
   local vHubNr="$1"    # IN

   cd "$vmdb_answer_BINDIR" && "$vmdb_answer_BINDIR"/"$natd" \
      -d /var/run/"$natd"-"$vHubNr".pid \
      -m /var/run/"$natd"-"$vHubNr".mac \
      -c "$vmware_etc_dir"/vmnet"$vHubNr"/nat/nat.conf
}

# Stop the NAT network user service
vmware_stop_nat() {
   local vHubNr="$1"   # IN

   if vmware_stop_pidfile /var/run/"$natd"-"$vHubNr".pid; then
      rm -f /var/run/"$natd"-"$vHubNr".pid
      rm -f /var/run/"$natd"-"$vHubNr".mac
   fi
}

if [ -e "$vmdb_answer_SBINDIR/vmware-ccagent" ]; then
   serverd=vmware-ccagent
fi

# See how we were called.
case "$1" in
   start)
      if [ -e "$vmware_etc_dir"/not_configured ]; then
         echo "`vmware_product_name`"' is installed, but it has not been (correctly) configured'
         echo 'for the running kernel. To (re-)configure it, invoke the'
         echo 'following command: '"$vmdb_answer_BINDIR"'/vmware-config.pl.'
         echo

         exit 1
      fi

      if vmware_inVM; then
         # Refuse to start services in a VM: they are useless
         exit 1
      fi

      echo 'Starting VMware services:'
      exitcode='0'

      vmware_exec 'Virtual machine monitor' vmware_start_vmmon
      exitcode=$(($exitcode + $?))

      if [ "`isPpuserNeeded`" = '1' ]; then
         vmware_exec 'Virtual bidirectional parallel port' vmware_start_vmppuser
         exitcode=$(($exitcode + $?))
      else
         # Try to load parport_pc. Failure is allowed as it does not exist
         # on kernels 2.0
         /sbin/modprobe parport_pc >/dev/null 2>&1
      fi

      if [ "$vmdb_answer_NETWORKING" = 'yes' ]; then
         vmware_exec 'Virtual ethernet' vmware_start_vmnet
         exitcode=$(($exitcode + $?))

         vHubNr=0
         while [ $vHubNr -lt 256 ]; do
            eval 'interface="$vmdb_answer_VNET_'"$vHubNr"'_INTERFACE"'
            eval 'hostaddr="$vmdb_answer_VNET_'"$vHubNr"'_HOSTONLY_HOSTADDR"'
            eval 'netmask="$vmdb_answer_VNET_'"$vHubNr"'_HOSTONLY_NETMASK"'
            if [ -n "$interface" ]; then
               vmware_create_vmnet "$vHubNr"
               vmware_exec 'Bridged networking on /dev/vmnet'"$vHubNr" \
                  vmware_start_bridge "$vHubNr" "$interface"
               exitcode=$(($exitcode + $?))
            elif [ -n "$hostaddr" -a -n "$netmask" ]; then
               vmware_create_vmnet "$vHubNr"
               eval 'samba="$vmdb_answer_VNET_'"$vHubNr"'_SAMBA"'
                  vmware_bg_exec 'Host-only networking on /dev/vmnet'"$vHubNr" \
                  vmware_start_hostonly "$vHubNr" 'vmnet'"$vHubNr" \
                  "$hostaddr" "$netmask" 'yes' "$samba"
               exitcode=$(($exitcode + $?))

               eval 'nat="$vmdb_answer_VNET_'"$vHubNr"'_NAT"'
               if [ "$nat" = 'yes' ]; then
                  vmware_exec 'NAT service on /dev/vmnet'"$vHubNr" \
                     vmware_start_nat "$vHubNr"
                  exitcode=$(($exitcode + $?))
               fi
            fi
            vHubNr=$(($vHubNr + 1))
         done
      fi

      if [ "$exitcode" -gt 0 ]; then
         # Set the 'not configured' flag
         touch "$vmware_etc_dir"'/not_configured'
         chmod 644 "$vmware_etc_dir"'/not_configured'
         db_add_file "$vmware_db" "$vmware_etc_dir"'/not_configured' \
            "$vmware_etc_dir"'/not_configured'
         exit 1
      fi

      if [ "`vmware_product`" = "wgs" ]; then
         if [ -e $vmware_etc_dir/vm-list ]; then
            vmware_exec 'Starting VMware virtual machines...' \
               "$vmdb_answer_SBINDIR"/"$serverd" -s -d
         fi
      fi

      [ -d /var/lock/subsys ] || mkdir -p /var/lock/subsys
      touch /var/lock/subsys/"$subsys"
   ;;

   stop)
      # need to do VM auto stop before unmounting vmfs disks, in case
      # we are suspending to VMFS files
      if [ "`vmware_product`" = "wgs" ]; then
         if [ "`vmmonUseCount`" -gt 0 ]; then
            echo "Stopping VMware virtual machines..."
            serverd_pid=`pidof $serverd`
            if [ -n "$serverd_pid" ]; then
               # This whole code is hella racy
               vmware_synchrone_kill "$serverd_pid" "USR1"
               # Wait for serverd to stop;
               # XXX: Add a finite timeout to give up at (maybe use serverd to guess the value)
               while [ -d /proc/"$serverd_pid" ]; do
                  sleep 1
               done
            else
               vmware_exec '' "$vmdb_answer_SBINDIR"/"$serverd" -k
            fi
         fi
      fi

      if [ "`vmmonUseCount`" -gt 0 ]; then
         echo 'At least one instance of '"`vmware_product_name`"' is still running.' 1>&2
         echo 'Please stop all running instances of '"`vmware_product_name`"' first.' 1>&2
         echo

         # The unconfigurator handle this exit code differently
         exit 2
      fi

      echo 'Stopping VMware services:'
      exitcode='0'

      vmware_exec 'Virtual machine monitor' vmware_stop_vmmon
      exitcode=$(($exitcode + $?))

      if [ "`isPpuserNeeded`" = '1' ]; then
         vmware_exec 'Virtual bidirectional parallel port' vmware_stop_vmppuser
         exitcode=$(($exitcode + $?))
      else
         # Try to unload parport_pc. Failure is allowed as it does not exist
         # on kernels 2.0, and some other process could be using it.
         /sbin/modprobe -r parport_pc >/dev/null 2>&1
      fi

      if [ "$vmdb_answer_NETWORKING" = "yes" ]; then
         # NB: must kill off processes using vmnet before
         #     unloading module
         vHubNr=0
         while [ $vHubNr -lt 256 ]; do
            eval 'interface="$vmdb_answer_VNET_'"$vHubNr"'_INTERFACE"'
            eval 'hostaddr="$vmdb_answer_VNET_'"$vHubNr"'_HOSTONLY_HOSTADDR"'
            eval 'netmask="$vmdb_answer_VNET_'"$vHubNr"'_HOSTONLY_NETMASK"'
            if [ -n "$interface" ]; then
               vmware_exec "Bridged networking on /dev/vmnet$vHubNr" \
					   vmware_stop_bridge "$vHubNr"
               exitcode=$(($exitcode + $?))
            elif [ -n "$hostaddr" -a -n "$netmask" ]; then
               vmware_exec "DHCP server on /dev/vmnet$vHubNr" vmware_stop_dhcpd \
                  "vmnet$vHubNr"
               exitcode=$(($exitcode + $?))

               eval 'samba="$vmdb_answer_VNET_'"$vHubNr"'_SAMBA"'
               if [ "$samba" = "yes" ]; then
                  vmware_exec 'SMB share server on /dev/vmnet'"$vHubNr" \
                     vmware_stop_smbd 'vmnet'"$vHubNr"
                  exitcode=$(($exitcode + $?))

                  vmware_exec 'SMB name server on /dev/vmnet'"$vHubNr" \
                     vmware_stop_nmbd 'vmnet'"$vHubNr"
                  exitcode=$(($exitcode + $?))
               fi

               eval 'nat="$vmdb_answer_VNET_'"$vHubNr"'_NAT"'
               if [ "$nat" = "yes" ]; then
                  vmware_exec 'NAT service on /dev/vmnet'"$vHubNr" \
                     vmware_stop_nat "$vHubNr"
                  exitcode=$(($exitcode + $?))
               fi

               vmware_exec 'Host-only networking on /dev/vmnet'"$vHubNr" \
                  vmware_stop_hostonly 'vmnet'"$vHubNr" "$hostaddr" "$netmask"
            fi
            vHubNr=$(($vHubNr + 1))
         done

         vmware_exec 'Virtual ethernet' vmware_stop_vmnet
            exitcode=$(($exitcode + $?))
      fi

      if [ "$exitcode" -gt 0 ]; then
         exit 1
      fi

      rm -f /var/lock/subsys/"$subsys"
   ;;

   status)
      if [ "`vmmonUseCount`" -gt 0 ]; then
         echo 'At least one instance of '"`vmware_product_name`"' is still running.'
         echo
         if [ "$2" = "vmcount" ]; then
            exit 2
         fi
      fi
      if [ "$2" = "vmcount" ]; then
            exit 0
      fi

      exitcode='0'
      if [ "$vmdb_answer_NETWORKING" = "yes" ]; then
         vHubNr=0
         while [ $vHubNr -lt 256 ]; do
            eval 'interface="$vmdb_answer_VNET_'"$vHubNr"'_INTERFACE"'
            eval 'hostaddr="$vmdb_answer_VNET_'"$vHubNr"'_HOSTONLY_HOSTADDR"'
            eval 'netmask="$vmdb_answer_VNET_'"$vHubNr"'_HOSTONLY_NETMASK"'
            if [ -n "$interface" ]; then
	            echo -n 'Bridged networking on /dev/vmnet'"$vHubNr"
	            if vmware_check_pidfile '/var/run/'"$bridge"'-'"$vHubNr"'.pid'; then
	               echo ' is running'
	            else 
	               echo ' is not running'
		            exitcode=$(($exitcode + 1))
	            fi
            elif [ -n "$hostaddr" -a -n "$netmask" ]; then
	            echo -n 'Host-only networking on /dev/vmnet'"$vHubNr"
	            if vmware_check_pidfile '/var/run/'"$netifup"'-vmnet'"$vHubNr".'pid'; then
	               echo ' is running'
	            else 
	               echo ' is not running'
		            exitcode=$(($exitcode + 1))
	            fi

               eval 'nat="$vmdb_answer_VNET_'"$vHubNr"'_NAT"'
               if [ "$nat" = 'yes' ]; then
	               echo -n 'NAT networking on /dev/vmnet'"$vHubNr"
	               if vmware_check_pidfile '/var/run/'"$natd"'-'"$vHubNr"'.pid'; then
	                  echo ' is running'
		            else 
	                  echo ' is not running'
		               exitcode=$(($exitcode + 1))
	               fi
               fi
            fi
            vHubNr=$(($vHubNr + 1))
         done
      fi

      echo -n "Module $driver "
      [ "`isLoaded "$driver"`" = 'yes' ] && echo loaded || echo "not loaded"
      if [ "`isPpuserNeeded`" = '1' ]; then
         echo -n "Module $ppuser "
         [ "`isLoaded "$ppuser"`" = 'yes' ] && echo loaded || echo "not loaded"
      fi
      if [ "$vmdb_answer_NETWORKING" = "yes" ]; then
         echo -n "Module $vnet "
         [ "`isLoaded "$vnet"`" = 'yes' ] && echo loaded || echo "not loaded"
      fi

      if [ "$exitcode" -gt 0 ]; then
         exit 1
      fi
   ;;

   restart)
      "$0" stop && "$0" start
   ;;

   *)
      echo "Usage: `basename "$0"` {start|stop|status|restart}"
      exit 1
esac

exit 0
