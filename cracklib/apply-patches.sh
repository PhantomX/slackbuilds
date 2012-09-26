
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
cp -f lib/packer.h lib/packer.h.in
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/cracklib-2.8.15-inttypes.patch

set +e +o pipefail
