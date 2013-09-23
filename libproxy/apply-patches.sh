
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-r873.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-0.4.11-fdleak.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-0.4.11-crash.patch

set +e +o pipefail
