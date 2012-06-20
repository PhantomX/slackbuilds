
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugs.kde.org/show_bug.cgi?id=299868
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.9.0.3-wpa2ent_dialog.patch
## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-cmake-error-when-processing-openconnect-plugin-s.patch

set +e +o pipefail
