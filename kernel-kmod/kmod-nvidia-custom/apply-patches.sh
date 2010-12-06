
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/256.35-unified-arch.patch
# http://www.nvnews.net/vbulletin/showthread.php?s=c12b55cadd03d751a3734651082f61d6&t=157678
patch -p1 -E --backup -z .msi --verbose -i ${SB_PATCHDIR}/nvidia-msi-fix.patch

set +e +o pipefail
