  
SB_PATCHDIR=${CWD}/patches

#zcat ${SB_PATCHDIR}/amarok-2.2.2-no_var_tracking.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/amarok-2.2.1.90-qtscript_not_required.patch.gz | patch -p1 -E --backup --verbose || exit 1

## upstream patches
# http://bugs.kde.org/220532
zcat ${SB_PATCHDIR}/amarok-2.2.2-kde\#220532.patch .gz | patch -p1 -E --backup --verbose || exit 1
