
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Arch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-more-syntax-keywords-for-service-and-socket-file.patch

set +e +o pipefail
