#!/bin/sh


DATE=$(date +%Y%m%d)
MODULE=$(basename $0 -cvs-checkout.sh)

set -x
rm -rf $MODULE 
#cvs -d:pserver:anonymous@geomview.cvs.sourceforge.net:/cvsroot/geomview login
cvs -z3 -d:pserver:anonymous@$MODULE.cvs.sourceforge.net:/cvsroot/$MODULE co -P $MODULE 

# auto*/configure bits
test -d $MODULE/admin || \
svn export svn://anonsvn.kde.org/home/kde/branches/KDE/3.5/kde-common/admin $MODULE/admin/

tar cjf $MODULE-cvs${DATE}.tar.bz2 $MODULE 

rm -rf $MODULE 

