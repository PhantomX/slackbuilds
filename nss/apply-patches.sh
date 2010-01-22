
SB_PATCHDIR=${CWD}/patches

# Apply the patches to the newer NSS tree
zcat ${SB_PATCHDIR}/nss-no-rpath.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nss-nolocalsql.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nss-enable-pem.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/533125-ammend.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nss-sysinit.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nss-538226.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/540387.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/545779.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/546221.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/547860.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/553638.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Uncomment this if builds stops with -lz error
#zcat ${SB_PATCHDIR}/nss-fix-zlib.patch.gz | patch -p0 -E --backup --verbose || exit 1
