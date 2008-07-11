#!/bin/sh
# floppy-extra-devs.sh
# by volkerdi at slackware dot com

# This is a handy pseudo-expr picked up from the MAKEDEV script:
math() {
  eval echo "\$(($*))"
}

# Add extra floppy devices (used only by fdformat, I think)
FLOPNUM=`echo $1 | cut -b 3`
for devpair in \
  d360:4  \
  h360:20 h720:24 h880:80 h1200:8 h1440:40 h1476:56 h1494:72 h1600:92 \
  u1440:28 u1600:124 u1680:44 u1722:60 u1743:76 u1760:96 u1840:116 u1920:100 \
  u2880:32 u3200:104 u3520:108 u3840:112 ; do
  FLOPDEV=`echo $devpair | cut -f 1 -d :`
  FLOPNOD=`echo $devpair | cut -f 2 -d :`
  mknod /dev/${1}${FLOPDEV} b 2 `math $FLOPNOD + $FLOPNUM`
  chown root:floppy /dev/${1}${FLOPDEV}
  chmod 660 /dev/${1}${FLOPDEV}
done
unset FLOPNUM FLOPDEV FLOPNOD devpair math

