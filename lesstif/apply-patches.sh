  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}.patch.gz | patch -p1 -E --backup --verbose || exit 1
# put mwm conf file in %{_sysconfdir}, and install Dt in %_libdir
zcat ${SB_PATCHDIR}/${NAME}-Makefile.in.diff.gz | patch -p1 -E --backup --verbose || exit 1
# have motif-config honor libdir
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-CAN-2005-0605.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-64bitcleanups.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-c++fix.patch.gz | patch -p1 -E --backup --verbose || exit 1

zcat ${CWD}/${PSRCARCHIVE} | patch -p1 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/${NAME}-0.95.0-scroll.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95-resource-fix.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95-text.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-XxxxProperty-64bit.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-accelkeys.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-attach-bottom-self.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-xtungrab-warning.patch.gz | patch -p1 -E --backup --verbose || exit 1
# remove reference to libdir, since it is not necessary, and leads to
# conflict in multiarch setups
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-nolibdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.95.0-PutPixel32.patch.gz | patch -p1 -E --backup --verbose || exit 1

# and pick up some fixes from Debian
patch -p1 < debian/patches/020_xpmpipethrough.diff
patch -p1 < debian/patches/021_xim_chained_list_crash.diff
patch -p1 < debian/patches/030_manpage.diff
patch -p1 < debian/patches/020_render_table_crash.diff
