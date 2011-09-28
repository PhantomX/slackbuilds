
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix bootstrap
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/dpkg-1.16.1-arch.patch

set +e +o pipefail
