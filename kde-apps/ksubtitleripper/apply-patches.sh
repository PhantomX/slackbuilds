
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/arts-acinclude.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/gocr.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/previewcrash.patch.gz | patch -p2 -E --backup --verbose
# Very dirty workarount for gcc 4.4.
zcat ${SB_PATCHDIR}/${NAME}-0.3.1-gcc44.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
