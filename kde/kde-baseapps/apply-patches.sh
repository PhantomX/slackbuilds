
SB_PATCHDIR=${CWD}/patches

set -e -o pipefail

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase.patch 
zcat ${SB_PATCHDIR}/kdebase-4.1.80-nsplugins-paths.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/kdebase-4.2.1-home-icon-slk.patch.gz | patch -p2 -E --backup --verbose

# Display menubar by default on dolphin
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.1-dolphin-menubar.patch

# fix disabling automatic spell checking in the Konqueror UI (kde#228593)
zcat ${SB_PATCHDIR}/kdebase-4.4.0-konqueror-kde\#228593.patch.gz | patch -p2 -E --backup --verbose

# Password & User account becomes non responding
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase-4.3.4-bz\#609039-chfn-parse.patch

## upstream patches
# https://projects.kde.org/projects/kde/kde-baseapps/repository/revisions/d8732a59d3b1f2d0bebf43f294df7e9f333abde4
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.2-dolphin_timeout.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.2-drag-drop-cursor.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.2-file-sizes.patch

#trunk patches

set +e +o pipefail
