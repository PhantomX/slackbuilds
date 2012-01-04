
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.40-openjpeg.patch
zcat ${SB_PATCHDIR}/${NAME}-3.31-libpng14.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
