
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-3.2.5-optflags.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.2.5-modularX.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.2.5-bitmap.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.2.5d-fig2mpdf-r1.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.2.5c-maxfontsize.patch

set +e +o pipefail
