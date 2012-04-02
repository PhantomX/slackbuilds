
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-0.4.7-js185.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-0.4.7-url-pac.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-0.4.7-webkit.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libproxy-0.4.7-unistd.patch

set +e +o pipefail
