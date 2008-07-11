# The set of patches from hell :)

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/qt-x11.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt.mysql.h.diff.gz | patch -p1 -E --backup --verbose || exit 1

# Visibility patch (for gcc >= 4.1)
zcat ${SB_PATCHDIR}/qt-3.3.8-visibility.patch.gz | patch -p0 -E --backup --verbose || exit 1

zcat ${SB_PATCHDIR}/qt-3.3.4-print-CJK.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.0.5-nodebug.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.1.0-makefile.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.7-umask.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.6-strip.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.2-quiet.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.3-qembed.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/qt-uic-nostdlib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.6-qfontdatabase_x11.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.3-gl.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.3.3-gtkstyle.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.5-gcc4-buildkey.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Patch for uic includehint errors (aseigo patch)
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.5-uic.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/qt-x11-free-3.3.8-uic-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-ml_IN-209097.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.3.8-fontrendering-as_IN-209972.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-te_IN-211259.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-214371.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.3.8-fontrendering-\#214570.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-ml_IN-209974.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-ml_IN-217657.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-gu-228452.patch.gz | patch -p1 -E --backup --verbose || exit 1

# immodule patches
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.8-qt-x11-immodule-unified-qt3.3.7-20061229-pre.patch.gz | patch -p1 -E --backup --verbose || exit 1
bzcat ${SB_PATCHDIR}/qt-x11-immodule-unified-qt3.3.7-20061229.diff.bz2 | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.8-qt-x11-immodule-unified-qt3.3.7-20061229-post.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-immodule-unified-qt3.3.5-20051012-quiet.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.6-fix-key-release-event-with-imm.diff.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.6-qt-x11-immodule-unified-qt3.3.5-20060318-resetinputcontext.patch.gz | patch -p1 -E --backup --verbose || exit 1

# qt-copy patches

zcat ${SB_PATCHDIR}/0080-net-wm-sync-request-2.patch.gz | patch -p0 -E --backup --verbose || exit 1

# 0080, 0085 don't apply atm, some/most of these are already included -- Rex
echo "0080" >> patches/DISABLED
echo "0085" >> patches/DISABLED
test -x apply_patches && ./apply_patches

# upstream patches
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.4-fullscreen.patch.gz | patch -p1 -E --backup --verbose || exit 1

# security patches

zcat ${SB_PATCHDIR}/qt-ulibc.patch.gz | patch -p1 -E --backup --verbose || exit 1

# xinerama patch: http://ktown.kde.org/~seli/xinerama/
# Disabled
#zcat ${SB_PATCHDIR}/${NAME}-3.3.8-seli-xinerama.patch.gz | patch -p0 -E --backup --verbose || exit 1

# eycandy patch(es)
zcat ${SB_PATCHDIR}/qt-3.3.8-eyecandy.patch.gz | patch -p1 -E --backup --verbose || exit 1
