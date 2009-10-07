  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/exmap-0.10-nowerror.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/exmap-0.10-no_libs_on_ldflags.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/exmap-0.10-nodebug.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/exmap-0.10-gmake.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/exmap-0.10-gcc43.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/exmap-0.10-2.6.27.patch.gz | patch -p0 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/exmap-0.10-2.6.30.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/exmap_453852_BAD_HACK_comment_out_bits_that_get_in_the_way.patch.gz | patch -p1 -E --backup --verbose || exit 1
