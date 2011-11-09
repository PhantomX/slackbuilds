
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-20090224-pythondl.patch.gz | patch -p1 -E --backup --verbose
# http://ftp.openbsd.org/ports/print/fontforge/patches/patch-gutils_gimagewritepng_c
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libpng15.patch

set +e +o pipefail
