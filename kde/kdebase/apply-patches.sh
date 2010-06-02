
SB_PATCHDIR=${CWD}/patches

set -e -o pipefail

zcat ${SB_PATCHDIR}/${NAME}-4.1.80-nsplugins-paths.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.1-home-icon-slk.patch.gz | patch -p1 -E --backup --verbose

# backwards compatibility hack for a config option changed by our old
# konsole-session patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-konsole-activetabindex.patch

# fix disabling automatic spell checking in the Konqueror UI (kde#228593)
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-konqueror-kde\#228593.patch.gz | patch -p1 -E --backup --verbose

# Mandriva
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-fix-execute-scripts.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-folderview-icon-text.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-configure-trashbin.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-handle-emptytrash.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.2-konsole-add-debug.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dolphin-icon-text.patch 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.2-add-menubar-shortcut.patch 
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-add-kcm-webcam.patch

#trunk patches
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.1-t1100886-fix-konqueror-crash.patch 

## upstream patches

set +e +o pipefail
