#!/bin/bash

DATE=$(date +%Y%m%d)
EXPORT_DIR=qt-copy

set -x
rm -rf $EXPORT_DIR

# trunk tracking qt-4.5 now
SVN_ROOT=svn://anonsvn.kde.org/home/kde/trunk/qt-copy

svn export --non-recursive $SVN_ROOT $EXPORT_DIR/
svn export $SVN_ROOT/patches $EXPORT_DIR/patches

pushd $EXPORT_DIR
rm -f ../qt-copy-patches-${DATE}svn.tar.bz2
tar cjf ../qt-copy-patches-${DATE}svn.tar.bz2 \
  .applied_patches apply_patches README.qt-copy patches/ 
popd

# cleanup
rm -rf $EXPORT_DIR

