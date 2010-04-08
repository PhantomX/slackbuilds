
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-Euro-and-New-Shekel-sign-to-israeli-layout.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-symbols-de-remove-BKSP-from-neo-layout.patch

set +e +o pipefail
