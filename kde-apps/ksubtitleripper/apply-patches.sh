
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/kde3-acinclude.patch.gz | patch -p1 -E --backup --verbose
patch -p1 --verbose --backup -i ${SB_PATCHDIR}/kde3-automake-add-missing.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kde-3.5.10-kde3-standarddirs.patch
zcat ${SB_PATCHDIR}/gocr.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/previewcrash.patch.gz | patch -p2 -E --backup --verbose
# Very dirty workarount for gcc 4.4.
zcat ${SB_PATCHDIR}/${NAME}-0.3.1-gcc44.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
