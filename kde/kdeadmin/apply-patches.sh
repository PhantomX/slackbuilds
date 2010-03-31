
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.4.0-slk-knetworkconf.patch.gz | patch -p1 -E --backup -z .slk --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.85-printing.patch.gz | patch -p1 -E --backup --verbose

## upstream patches

set +e +o pipefail
