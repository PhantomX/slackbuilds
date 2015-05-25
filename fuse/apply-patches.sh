
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fuse-0001-More-parentheses.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fuse-2.9.2-namespace-conflict-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gold-unversioned-symbol.patch

set +e +o pipefail
