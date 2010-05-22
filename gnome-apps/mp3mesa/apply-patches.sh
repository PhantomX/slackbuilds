
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup -z .default --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-default.patch
zcat ${SB_PATCHDIR}/grip-cell-renderer.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/grip-3.2.0-id3.c.patch.gz | patch -p1 -E --backup --verbose || exit 1
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.0.3-desktop.patch
zcat ${SB_PATCHDIR}/grip-3.3.1-implicit-declaration.patch.gz | patch -p1 -E --backup --verbose || exit 1

set +e +o pipefail
