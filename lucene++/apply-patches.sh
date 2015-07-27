
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-FSDirectory-sync-to-sync-writes-to-disk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-minor-fix-to-allow-full-lines-to-be-input-to-demo-qu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Use-maxSize-of-BooleanQuery-as-base-for-the-queue-si.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0006-Fix-packageconfig-path.patch
# https://github.com/luceneplusplus/LucenePlusPlus/pull/96
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lucene++-boost158.patch

set +e +o pipefail
