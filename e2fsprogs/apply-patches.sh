
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-1.40.4-sb_feature_check_ignore.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.41.12-EOFBLOCKS-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.41.12-relax-resize2fs-P.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.41.12-e4defrag.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.41.12-UTF8-chars.patch

set +e +o pipefail
