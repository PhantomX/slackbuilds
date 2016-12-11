
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.1.3-escape.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.1.5-pthread.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.1.98-arm.patch
#Bug: http://svn.netlabs.org/kbuild/ticket/117
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.1.9998-glob.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-wrong-memset.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.1.9998-ppc64le.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-0.1.9998-aarch64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-PKMKCCEVALPROG.patch

set +e +o pipefail
