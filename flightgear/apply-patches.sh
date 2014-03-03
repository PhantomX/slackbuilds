
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-check-to-be-sure-that-n-is-not-being-set-as-format-t.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-make-ShivaVG-and-FGAdminUI-static-libraries.patch

set +e +o pipefail
