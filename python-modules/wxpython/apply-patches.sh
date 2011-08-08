
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wxpython-2.8.9-wxversion-scripts.patch
# backport to wxGTK 2.8.10 API
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/wxPython-2.8.10-backport.patch

set +e +o pipefail
