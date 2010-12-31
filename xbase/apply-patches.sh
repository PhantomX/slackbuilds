
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xbase-3.1.2-fixconfig.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xbase-3.1.2-gcc44.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xbase-2.0.0-ppc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xbase-3.1.2-xbnode.patch

set +e +o pipefail
