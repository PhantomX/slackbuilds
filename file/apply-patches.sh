  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.quiet.diff.gz | patch -p0 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}.short.diff.gz | patch -p1 -E --verbose || exit 1
[ "${SB_PYTHON}" = "YES" ] && \
  zcat ${SB_PATCHDIR}/${NAME}-4.21-pybuild.diff.gz | patch -p1 -E --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-4.15-libtool.patch.gz | patch -p0 -E --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-4.24-selinux.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.21-oracle.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.24-ooffice.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.24-dump.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.24-berkeleydb.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.20-xen.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.21-svn.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.20-images.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.20-apple.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.24-audio.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.20-add-lzma.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-4.23-lzma-cointainer.patch.gz | patch -p1 -E --backup --verbose || exit 1

rm -f magic/Magdir/*~
