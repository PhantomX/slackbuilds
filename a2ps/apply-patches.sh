  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/a2ps-4.13-conf-slk.patch.gz | patch -p1 -E --backup -z .conf --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13-etc.patch.gz | patch -p1 -E --backup -z .etc --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13-security.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13-glibcpaper.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-sort.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-iso5-minus.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-perl.patch.gz | patch -p1 -E --backup --verbose || exit 1
# EUC-JP support
zcat ${SB_PATCHDIR}/a2ps-4.13-eucjp.patch.gz | patch -p1 -E --backup -z .euc --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13-autoenc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13b-attr.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13b-numeric.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13b-encoding.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13b-tilde.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13-euckr.patch.gz | patch -p1 -E --backup -z .euckr --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13-gnusource.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.13-hebrew.patch.gz | patch -p1 -E --backup -z .hebrew --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-make-fonts-map.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-wdiff.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-U.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-mb.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-external-libtool.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/a2ps-4.14-texinfo-nodes.patch.gz | patch -p1 -E --backup --verbose || exit 1
