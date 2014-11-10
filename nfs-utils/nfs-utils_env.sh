#!/bin/sh

# extract configuration from /etc/sysconfig/nfs-utils and write
# environment to /run/sysconfig/nfs-utils to be used by systemd unit
# files.

nfs_config=/etc/default/nfs
if test -r $nfs_config; then
    . $nfs_config
fi

if [ "$RPCNFSDCOUNT" -gt 0 ]; then
    nfsds=$RPCNFSDCOUNT
else
    nfsds=8
fi

if [ -n "$RPCNFSDARGS" ]; then
	nfsdargs="$RPCNFSDARGS $nfsds"
else
	nfsdargs="$nfsds"
fi

mkdir -p /run/default
{
echo RPCNFSDARGS="$nfsdargs"
echo RPCMOUNTDOPTS="$RPCMOUNTDOPTS"
echo STATDARG="$STATDARG"
echo RPCIDMAPDARGS="$RPCIDMAPDARGS"
echo RPCGSSDARGS="$RPCGSSDARGS"
echo RPCSVCGSSDARGS="$RPCSVCGSSDARGS"
echo BLKMAPDARGS="$BLKMAPDARGS"
} > /run/sysconfig/nfs-utils
