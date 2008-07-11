#/bin/sh

DATE=$(date +%Y%m%d)
MODULE="$(basename $0 -svn_checkout.sh)"
SVNROOT=svn://anonsvn.kde.org/home/kde/trunk/playground/network

set -x
rm -rf $MODULE

## my (rhel4) version of subversion didn't like non-recursive for 'export', but 'checkout' works
svn --non-recursive checkout $SVNROOT $MODULE/ 

## auto*/configure bits
svn up $MODULE

## app
svn export $SVNROOT/$MODULE $MODULE/$MODULE

## tar it up
tar cjf $MODULE-${DATE}svn.tar.bz2 $MODULE

## cleanup
rm -rf $MODULE

