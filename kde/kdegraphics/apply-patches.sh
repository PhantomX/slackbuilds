
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.2.2-workaround-kolorpaintcrash.patch.gz | patch -p1 -E --backup --verbose

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.2-okular_xps_hack.patch

set +e +o pipefail
