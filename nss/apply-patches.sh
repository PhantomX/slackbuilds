
SB_PATCHDIR=${CWD}/patches

# Apply the patches to the newer NSS tree
zcat ${SB_PATCHDIR}/nss-no-rpath.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nss-nolocalsql.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nss-enable-pem.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/nss-pem509705.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/newargs.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/sysinit.patch.gz | patch -p0 -E --backup --verbose || exit 1
