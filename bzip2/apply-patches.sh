
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/bzip2.saneso.diff
zcat ${SB_PATCHDIR}/bzip2-1.0.4-bzip2recover.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
