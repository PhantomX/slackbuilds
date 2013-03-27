#!/bin/bash

# This script generates /etc/rndc.key if doesn't exist

if [ ! -s /etc/rndc.key ]; then
  echo -n "Generating /etc/rndc.key:"
  if /usr/sbin/rndc-confgen -a > /dev/null 2>&1; then
    chmod 640 /etc/rndc.key
    chown root.named /etc/rndc.key
    [ -x /sbin/restorecon ] && /sbin/restorecon /etc/rndc.key
    echo -n "/etc/rndc.key generation" ; echo -e "\t\t[  OK  ]\r"
  else
    echo -n "/etc/rndc.key generation" ; echo -e "\t\t[FAILED]\r"
  fi
fi
