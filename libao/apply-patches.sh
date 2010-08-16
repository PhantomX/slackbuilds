
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://trac.xiph.org/ticket/1689
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/ao-pulse-fixes.patch

set +e +o pipefail
