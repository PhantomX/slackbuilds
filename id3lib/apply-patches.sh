
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-dox.patch.gz | patch -p0 -E --backup --verbose
bzcat ${SB_PATCHDIR}/${NAME}-3.8.3-libtool-autofoo.patch.bz2 | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.8.3-io_helpers-163101.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.8.3-mkstemp.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.8.3-includes.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.8.3-autoconf259.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-3.8.3-test_io.patch.gz | patch -p1 -E --backup --verbose
rm -rf zlib
patch -p1 -E --backup -z .zlib --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.3-die-local-zlib.patch

# http://launchpadlibrarian.net/33114077/id3lib-vbr_buffer_overflow.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-vbr_buffer_overflow.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/20-create-manpages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/60-fix_make_check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/60-id3lib-missing-nullpointer-check.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/60-add-c-wrapper-functions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/id3lib-3.8.3-fix-utf16-stringlists.patch

set +e +o pipefail
