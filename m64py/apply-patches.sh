
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .orig --verbose -i ${SB_PATCHDIR}/m64py-0.1.6-path.patch
patch -p0 -E --backup -z .orig --verbose -i ${SB_PATCHDIR}/m64py-0.1.6-libdir.patch
patch -p0 -E --backup -z .orig --verbose -i ${SB_PATCHDIR}/m64py-0.1.6-numpy.patch

set +e +o pipefail
