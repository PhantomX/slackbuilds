
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-build-everything.patch
zcat ${SB_PATCHDIR}/${NAME}-fix-labels.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-valgrind.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-fix-return-value.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-build-fixes.patch
# reisefs http://article.gmane.org/gmane.comp.file-systems.btrfs/5596
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-convert-reiserfs-1.patch
mv convert.c convert/
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-convert-reiserfs-2.patch

set +e +o pipefail
