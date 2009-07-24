  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-20070717svn-codec-libtiff.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-svn480-cmake.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-svn480-use-stdbool.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.3-tcd_init_encode-alloc-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-1.3-reverse-bogus-aligned-malloc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-svn468-mj2-noscroll.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20070717svn-mqc-optimize.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20070821svn-t1-remove-macro.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20070719svn-t1-x86_64-flags-branchless.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20070719svn-t1-t1_dec_sigpass_step-optimize.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20070821svn-t1-flags-stride.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20070821svn-t1-updateflags-x86_64.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-svn470-t1-flags-mmx.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-20070719svn-mqc-more-optimize.patch.gz | patch -p1 -E --backup --verbose || exit 1

## upstreamable patches
# libopenjpeg has undefined references, http://bugzilla.redhat.com/467661
zcat ${SB_PATCHDIR}/${NAME}-1.3-libm.patch.gz | patch -p1 -E --backup --verbose || exit 1
