
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libmpeg2-0.5.1-configure.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
