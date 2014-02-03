
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.4-rcopshack.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.4-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.4-s4u2proxy.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.4-httpd24.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.4-delegation.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.4-cachedir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.4-longuser.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-5.4-handle-continue.patch

set +e +o pipefail
