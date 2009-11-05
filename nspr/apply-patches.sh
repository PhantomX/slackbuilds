
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/nspr-config-pc.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nspr-bug-487844.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nspr-4.6.1-lang.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nspr-4.7.0-prtime.patch.gz | patch -p0 -E --backup --verbose || exit 1
