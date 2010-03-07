
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Apply the patches to the newer NSS tree
zcat ${SB_PATCHDIR}/nss-no-rpath.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/nss-nolocalsql.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/renegotiate-transitional.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/validate-arguments.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/nss-enable-pem.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/533125-ammend.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/nss-538226.patch.gz | patch -p0 -E --backup --verbose
# Uncomment this if builds stops with -lz error
#zcat ${SB_PATCHDIR}/nss-fix-zlib.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
