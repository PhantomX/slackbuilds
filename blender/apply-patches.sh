
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.44-bid.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .ext --verbose -i ${SB_PATCHDIR}/${NAME}-2.58-ext.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.57-syspath.patch

set +e +o pipefail
