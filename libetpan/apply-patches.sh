
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-multiarch.patch
# https://github.com/dinhviethoa/libetpan/pull/91
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-gnutls.patch

set +e +o pipefail
