
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jed-0.99.12-xkeys.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jed-etc.patch
[ "${ARCH}" = "x86_64" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/jed-multilib-newauto.patch

set +e +o pipefail
