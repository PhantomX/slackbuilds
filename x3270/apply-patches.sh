
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/x3270-3.3.10-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/x3270-3.3.10-ibmhostpath.patch

set +e +o pipefail
