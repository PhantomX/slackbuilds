  
SB_PATCHDIR=${CWD}/patches

bzcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0001-cuetag.sh-Fix-metaflac-options-for-flac-1.1.3.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0002-cuetag.sh-Fix-handling-of-files-with-spaces.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/0003-cuetag.sh-Correct-typo-in-error-output.patch.gz | patch -p1 -E --backup --verbose || exit 1
