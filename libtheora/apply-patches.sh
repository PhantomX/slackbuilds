
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libtheora-1.1.1-fix-pp_sharp_mod-calc.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libtheora-1.1.1-libpng16.patch

set +e +o pipefail
