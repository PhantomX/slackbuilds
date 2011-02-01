
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.1-docbook_fix.patch
# http://websvn.kde.org/?view=revision&revision=1213128
patch -p4 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.1.1-exiv2_021.patch

set +e +o pipefail
