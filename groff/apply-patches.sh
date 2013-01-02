
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-missing-groff-x11-info-message-when-gxditview-not-fo.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-various-security-fixes.patch

set +e +o pipefail
