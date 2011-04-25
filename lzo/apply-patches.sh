
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .configure --verbose -i ${SB_PATCHDIR}/lzo-2.05-configure.patch

set +e +o pipefail
