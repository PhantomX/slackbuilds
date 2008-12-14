
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/rpm-4.5.90-devel-autodep.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.5.90-pkgconfig-path.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.5.90-gstreamer-provides.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/rpm-4.6.0-rc1-defaultdocdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/rpm-4.5.90-posttrans.patch.gz | patch -p1 -E --backup --verbose || exit 1
