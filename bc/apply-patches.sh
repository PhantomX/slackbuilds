
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/bc-1.06-dc_ibase.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bc-1.06.95-memleak.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bc-1.06.95-matlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bc-1.06.95-sigintmasking.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bc-1.06.95-doc.patch

set +e +o pipefail
