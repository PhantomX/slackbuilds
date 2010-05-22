
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-3.3.1-default.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-cell-renderer.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.2.0-id3.c.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.3.1-desktop.patch.gz | patch -p0 -E --backup --verbose

zcat ${SB_PATCHDIR}/${NAME}-3.3.1-implicit-declaration.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
