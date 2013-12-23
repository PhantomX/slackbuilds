
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libmediainfo-0.7.65-nola.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libmediainfo-0.7.50-libmms.patch

set +e +o pipefail
