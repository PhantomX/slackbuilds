
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.1.5-autotoolize.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.1.4-lunatic.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.1.4-idsize.patch

set +e +o pipefail
