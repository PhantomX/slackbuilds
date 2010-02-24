#!/bin/bash
# Copyright 2008 Tom "spot" Callaway <tcallawa@redhat.com>
# Permission to use, copy, modify, distribute, and sell this software and its
# documentation for any purpose is hereby granted without fee, provided that
# the above copyright notice appear in all copies and that both that
# copyright notice and this permission notice appear in supporting
# documentation.  No representations are made about the suitability of this
# software for any purpose.  It is provided "as is" without express or
# implied warranty.
# 
# Ensure that xmms2d is running before the client.

PIDFILE=/var/tmp/xmms2d
ARGS=1

if [ $# -ne "$ARGS" ]; then
   echo "Usage: `basename $0` xmms2-client"
   exit 65
fi

if [ -f $PIDFILE ]; then
   # Okay, we found the pidfile
   XMMS2PID=`cat $PIDFILE`
   XMMS2DINPS=`ps $XMMS2PID |grep xmms2d`
   if [ -z "$XMMS2DINPS" ]; then
	xmms2-launcher -P $PIDFILE &> /dev/null
   fi
else
   # Okay, so the pid file isn't there. Launch xmms2d anyway.
   xmms2-launcher -P $PIDFILE &> /dev/null
fi

$1
