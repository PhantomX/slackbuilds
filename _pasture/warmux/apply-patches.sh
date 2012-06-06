
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/warmux-11.04.1-zlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gcc-fix.patch

set +e +o pipefail
