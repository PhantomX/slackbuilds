
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patch from Arnold, the upstream maintainer:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gawk-3.1.8-syntax.patch
# http://lists.gnu.org/archive/html/bug-gnu-utils/2010-11/msg00005.html
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/gawk-3.1.8-double-free-wstptr.patch

set +e +o pipefail
