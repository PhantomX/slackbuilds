
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-multiarch.patch
patch -p0 -E --backup --verbose -z .gnutls -i ${SB_PATCHDIR}/${NAME}-gnutls.patch

set +e +o pipefail
