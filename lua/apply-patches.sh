
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.1.4-autotoolize.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.1.4-lunatic.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lua-5.1.4-idsize.patch
patch -p0 -E --backup --verbose -d src -i ${SB_PATCHDIR}/lua-5.1.4-2.patch

set +e +o pipefail
