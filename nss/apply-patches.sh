
SB_PATCHDIR=${CWD}/patches

# Apply the patches to the newer NSS tree
zcat ${SB_PATCHDIR}/${NAME}-no-rpath.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-nolocalsql.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-pem-bug429175.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-enable-pem.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-fix-tests.patch.gz | patch -p0 -E --backup --verbose || exit 1
