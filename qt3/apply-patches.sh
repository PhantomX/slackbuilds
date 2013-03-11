
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/qt-x11.diff.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt.mysql.h.diff.gz | patch -p1 -E --backup --verbose

# Visibility patch (for gcc >= 4.1)
zcat ${SB_PATCHDIR}/qt-3.3.8-visibility.patch.gz | patch -p0 -E --backup --verbose

zcat ${SB_PATCHDIR}/qt-3.3.4-print-CJK.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.0.5-nodebug.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.1.0-makefile.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.7-umask.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.6-strip.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.2-quiet.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.3-qembed.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-uic-nostdlib.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.6-qfontdatabase_x11.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.3-gl.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.3.3-gtkstyle.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.5-gcc4-buildkey.patch.gz | patch -p1 -E --backup --verbose
# Patch for uic includehint errors (aseigo patch)
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.5-uic.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-x11-free-3.3.8b-uic-multilib.patch
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-ml_IN-209097.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.3.8-fontrendering-as_IN-209972.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-te_IN-211259.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-214371.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.3.8-fontrendering-\#214570.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-ml_IN-209974.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-ml_IN-217657.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-3.3.6-fontrendering-gu-228452.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.8-odbc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.8b-sane_defaults.patch.gz | sed \
  -e "s|@@KDE3_PLUGIN_PATH@@|/usr/lib${LIBDIRSUFFIX}/kde3/plugins|" \
  | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-x11-free-3.3.8b-cstddef.patch
# fix aliasing issue in qlocale.cpp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-x11-free-3.3.8b-qlocale-aliasing.patch
# silence compiler warning in qimage.h by adding parentheses
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-x11-free-3.3.8b-qimage-parentheses.patch
# fix the include path for zlib.h in qcstring.cpp to pick up the system version
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qt-x11-free-3.3.8b-system-zlib-header.patch

# immodule patches
bzcat ${SB_PATCHDIR}/qt-x11-immodule-unified-qt3.3.8-20071116.diff.bz2 | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-immodule-unified-qt3.3.5-20051012-quiet.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.8b-fix-key-release-event-with-imm.diff.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.6-qt-x11-immodule-unified-qt3.3.5-20060318-resetinputcontext.patch.gz | patch -p1 -E --backup --verbose

# qt-copy patches

zcat ${SB_PATCHDIR}/0080-net-wm-sync-request-2.patch.gz | patch -p0 -E --backup --verbose

# For 0088
rm -f include/private/qt_x11_p.h
cp src/kernel/qt_x11_p.h include/private/qt_x11_p.h

# 0080, 0085 don't apply atm, some/most of these are already included -- Rex
echo "0080" >> patches/DISABLED
echo "0085" >> patches/DISABLED
test -x apply_patches && ./apply_patches

rm -f include/private/qt_x11_p.h
ln -sf ../../src/kernel/qt_x11_p.h include/private/qt_x11_p.h

# upstream patches
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.4-fullscreen.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/qt-x11-free-3.3.8b-gcc43.patch.gz | patch -p1 -E --backup --verbose

# security patches

zcat ${SB_PATCHDIR}/qt-ulibc.patch.gz | patch -p1 -E --backup --verbose

# xinerama patch: http://ktown.kde.org/~seli/xinerama/
# Disabled
#zcat ${SB_PATCHDIR}/${NAME}-3.3.8-seli-xinerama.patch.gz | patch -p0 -E --backup --verbose

# eycandy patch(es)
zcat ${SB_PATCHDIR}/qt-3.3.8-eyecandy.patch.gz | patch -p1 -E --backup --verbose

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/qt-3.3.8-libpng15.patch

set +e +o pipefail
