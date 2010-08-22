
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-2.1.6-vorbis-delimiter.patch.gz | patch -p1 -R -E --backup --verbose
patch -p1 -R -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.6-flac-delimiter.patch
zcat ${SB_PATCHDIR}/${NAME}-2.1.6-id3lib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.1.6-cddb_manual_search_fix.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.1.6-new_libmp4v2.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.6-flac-picture.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.6-load-from-txt.patch

set +e +o pipefail
