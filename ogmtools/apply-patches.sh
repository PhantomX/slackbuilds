  
SB_PATCHDIR=${CWD}/patches

# touch -r configure.in configure.in.stamp
#zcat ${SB_PATCHDIR}/${NAME}-1.5-optflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
# touch -r configure.in configure.in.stamp
zcat ${SB_PATCHDIR}/${NAME}-1.5-comments.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.5-endian-fix.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.5-vorbis_verbosity.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.5-summary_length.patch.gz | patch -p1 -E --backup --verbose || exit 1
