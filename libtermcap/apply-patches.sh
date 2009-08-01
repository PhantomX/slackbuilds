  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/termcap-compat_${VERSION}.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/termcap.h.diff.gz | patch -p0 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/termcap.bufsize.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
