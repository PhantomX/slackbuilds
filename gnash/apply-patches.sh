
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/gnash-0.8.3-boost-dynamic-link.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/gnash-0.8.3-fix-kde4-port.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
