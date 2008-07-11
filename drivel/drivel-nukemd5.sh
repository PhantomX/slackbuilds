#!/bin/sh
#
# Remove the MD5 implementation from drivel.  A subsequent patch
# fixes the source to use the beecrypt MD5 implementation instead.
#

for i in src/md5.* ; do > $i ; done
