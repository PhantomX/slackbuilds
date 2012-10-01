
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-3.0.1.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/osg-xine-1.2.patch

set +e +o pipefail
