  
SB_PATCHDIR=${CWD}/patches

# don't use -b on mkspec files, else they get installed too.
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.2.2-multilib.patch.gz | patch -p1 -E --verbose || exit 1

zcat ${SB_PATCHDIR}/${PNAME}-all-opensource-src-4.4.0-rc1-as_IN-437440.patch.gz | patch -p1 -E --verbose || exit 1

# kill hardcoded font substitutions (#447298)
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.3.4-no-hardcoded-font-aliases.patch.gz | patch -p1 -E --verbose || exit 1
# under GNOME, default to QGtkStyle if available
# (otherwise fall back to QCleanlooksStyle)
zcat ${SB_PATCHDIR}/${PNAME}-x11-opensource-src-4.4.0-qgtkstyle.patch.gz | patch -p1 -E --verbose || exit 1


# qt-copy patches
test -x apply_patches && ./apply_patches
