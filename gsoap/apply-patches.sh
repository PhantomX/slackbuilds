
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/use_libtool-2.8.0.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gsoap-2.7-iostream.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gsoap-2.7-examples.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gsoap-2.7-noexec-examples.patch

set +e +o pipefail
