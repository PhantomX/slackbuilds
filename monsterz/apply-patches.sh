
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.1-userpmopts.patch
[ "${ARCH}" = "x86_64" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.1-64bitfix.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.1-blit-crash.patch

set +e +o pipefail
