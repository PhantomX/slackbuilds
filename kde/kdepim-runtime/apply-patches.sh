
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .show --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.0-show-akonadi-kcm.patch

# upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Make-it-compile-with-gcc-4.4.patch

set +e +o pipefail
