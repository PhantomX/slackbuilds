  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/docbook-xsl-pagesetup.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/docbook-xsl-marginleft.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/docbook-xsl-newmethods.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/docbook-xsl-non-constant-expressions.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/docbook-xsl-list-item-body.patch.gz | patch -p1 -E --backup --verbose || exit 1
