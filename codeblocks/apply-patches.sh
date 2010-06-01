
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# fix for gcc 4.4/glibc 2.9.90 http://developer.berlios.de/patch/index.php?func=detailpatch&patch_id=2699&group_id=5358
zcat ${SB_PATCHDIR}/${NAME}-drop-const.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dso.patch

set +e +o pipefail
