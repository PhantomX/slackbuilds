  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/attr.destdir.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/attr-2.4.43-leak.patch.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/attr-2.4.44-gettext.patch.gz | patch -p0 --verbose --backup --suffix=.orig || exit 1
