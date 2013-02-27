
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/graphite-arm-nodefaultlibs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/graphite2-1.2.0-cmakepath.patch

set +e +o pipefail
