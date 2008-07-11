
SB_PATCHDIR=${CWD}/patches

# Patches from Mandriva
zcat ${SB_PATCHDIR}/${NAME}-20061224-64bit-fixes.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.6-fixdnssd.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.6-32bit.patch.gz | patch -p1 -E --backup --verbose || exit 1
# zcat ${CWD}/${NAME}-0.6-fixplugins.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.6-avahi.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.6-fixbuild.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.6-ffmpeg.patch.gz | patch -p0 -E --backup --verbose || exit 1
