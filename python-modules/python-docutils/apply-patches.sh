
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/docutils-test-exceptions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/docutils-encoding.patch

set +e +o pipefail
