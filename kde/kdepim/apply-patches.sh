
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .install-headers --verbose -i ${SB_PATCHDIR}/${NAME}-4.11.90-install_kleopatra_headers.patch
patch -p1 -E --backup -z .boost --verbose -i ${SB_PATCHDIR}/${NAME}-4.14.3-boost157.patch

# Trunk Patches

# upstream patches

set +e +o pipefail
