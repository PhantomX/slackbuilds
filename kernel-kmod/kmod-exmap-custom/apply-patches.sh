
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/exmap-0.10-gmake.patch
zcat ${SB_PATCHDIR}/exmap-0.10-2.6.27.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/exmap-0.10-2.6.30.patch.gz | patch -p2 -E --backup --verbose

set +e +o pipefail
