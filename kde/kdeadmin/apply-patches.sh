
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .slk --verbose -i  ${SB_PATCHDIR}/${NAME}-4.5.0-slk-knetworkconf.patch
zcat ${SB_PATCHDIR}/${NAME}-4.2.85-printing.patch.gz | patch -p1 -E --backup --verbose

## upstream patches

set +e +o pipefail
