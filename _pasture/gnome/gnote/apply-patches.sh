
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnote-0.7.3-boost-filesystem.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnote-0.7.3-signal.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Use-search-by-default-in-the-desktop-file.patch

set +e +o pipefail
