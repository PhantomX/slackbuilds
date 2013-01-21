
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Gentoo.
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.4.3-boost150.patch

set +e +o pipefail
