  
SB_PATCHDIR=${CWD}/patches


zcat ${SB_PATCHDIR}/${NAME}-20090410svn-uniconv.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20090410svn-formats.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20090925svn-el5.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20091101svn-icon.patch.gz | patch -p0 -E --backup --verbose || exit 1
# https://bugs.launchpad.net/inkscape/+bug/487038
zcat ${SB_PATCHDIR}/${NAME}-0.47-poppler-0.12.2.patch.gz | patch -p1 -E --backup --verbose || exit 1
