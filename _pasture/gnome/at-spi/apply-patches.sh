
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-evo-crash.patch.gz | patch -p1 -E --backup --verbose
# http://lists.fedoraproject.org/pipermail/desktop/2010-October/006568.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/use-orbit-stack.patch

set +e +o pipefail
