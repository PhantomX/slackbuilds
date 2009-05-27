  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-startfluxbox-pulseaudio.patch.gz | patch -p0 -E --backup --verbose || exit 1

# Patch to handle a broken key file gracefully, #263379
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-macrocmd-crash.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Patch to quiet fbsetbg on upgrade
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-fbsetbg-quiet.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Patch to fix window focus bug when you have "focus-follows-mouse"
zcat ${SB_PATCHDIR}/${NAME}-1.1.1-mousefocus.patch.gz | patch -p1 -E --backup --verbose || exit 1
