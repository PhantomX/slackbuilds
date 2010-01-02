  
SB_PATCHDIR=${CWD}/patches

# put mwm conf file in %{_sysconfdir}, and install Dt in %_libdir
zcat ${SB_PATCHDIR}/${NAME}-Makefile.in.diff.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-0.95.2-motif-config.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-XxxxProperty-64bit.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-PutPixel32.patch.gz | patch -p1 -E --backup --verbose || exit 1

# and pick up some fixes from Debian
patch -p1 < debian/patches/020_missing_xm_h.diff || exit 1
patch -p1 < debian/patches/020_xpmpipethrough.diff || exit 1
patch -p1 < debian/patches/030_manpage.diff || exit 1
patch -p1 < debian/patches/020_render_table_crash.diff || exit 1
