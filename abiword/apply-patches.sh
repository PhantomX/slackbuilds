
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-2.6.0-desktop.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6.0-boolean.patch.gz | patch -p1 -E --backup --verbose || exit 1

# abiword-plugins
( cd ${SRCDIR2} || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-plugins-2.6.0-boolean.patch.gz | patch -p1 -E --backup --verbose || exit 1
) || exit 1

# abiword documentation
( cd ${SRCDIR4} || exit 1
  zcat ${SB_PATCHDIR}/${NAME}-2.6.0-windowshelppaths.patch.gz | patch -p1 -E --backup --verbose || exit 1
) || exit 1
