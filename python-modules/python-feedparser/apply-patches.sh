
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/feedparser_utf8_decoding.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/democracynow_feedparser_fix.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
