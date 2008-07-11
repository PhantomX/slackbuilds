#!/bin/sh
# Make kde-l10n packages
# by PJV <volkerdi@slackware.com>

export KDEVER=1.6.1
export PKVER=1.6.1
export ARCH=noarch
export BUILD=1xinc
export LC_ALL=C

CWD=`pwd`
for file in *.tar.bz2 ; do
  ( tar xjvf $file
    cd $CWD/koffice-$(echo $(basename $file .tar.bz2) | cut -f 2- -d -)
    ./configure --prefix=/opt/kde --program-prefix="" --program-suffix=""
    rm -rf $CWD/tmp
    make -i
    make -i install DESTDIR=$CWD/tmp
  )
  mkdir -p $CWD/tmp/install
  cat $CWD/slack-desc/slack-desc.`basename $file -$KDEVER.tar.bz2` > $CWD/tmp/install/slack-desc
  ( cd $CWD/tmp
    makepkg -l y -c n $CWD/`basename $file $KDEVER.tar.bz2`$PKVER-$ARCH-$BUILD.tgz
  )
  rm -r $CWD/koffice-$(echo $(basename $file .tar.bz2) | cut -f 2- -d -)
  rm -rf $CWD/tmp
done
rm -f $CWD/Colors $CWD/scan.before $CWD/scan.after
