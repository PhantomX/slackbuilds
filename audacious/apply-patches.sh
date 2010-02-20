  
SB_PATCHDIR=${CWD}/patches

# not submitted upstream, code section is gone in post-2.2
zcat ${SB_PATCHDIR}/${NAME}-2.2-disabled-iplugins.patch.gz | patch -p1 -E --backup --verbose || exit 1
# obsolete with version upgrade
zcat ${SB_PATCHDIR}/${NAME}-2.2-AUD-99.patch.gz | patch -p1 -E --backup --verbose || exit 1
# obsolete with version upgrade
zcat ${SB_PATCHDIR}/${NAME}-2.2-pkgconfig-libs.patch.gz | patch -p1 -E --backup --verbose || exit 1
# for a problem that is known upstream, but 2.3-alpha1 doesn't fixed it yet
# iplugin sorting order is important, too
zcat ${SB_PATCHDIR}/${NAME}-2.2-multiple-decoders-per-ext.patch.gz | patch -p1 -E --backup --verbose || exit 1
# tuple.c part merged upstream
zcat ${SB_PATCHDIR}/${NAME}-2.2-set_tuple_cb.patch.gz | patch -p1 -E --backup --verbose || exit 1
#
zcat ${SB_PATCHDIR}/${NAME}-2.2-libm.patch.gz | patch -p1 -E --backup --verbose || exit 1
# obsolete with version upgrade
zcat ${SB_PATCHDIR}/${NAME}-2.2-coverart.patch.gz | patch -p1 -E --backup --verbose || exit 1
