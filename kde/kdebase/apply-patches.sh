
SB_PATCHDIR=${CWD}/patches

set -e -o pipefail

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch 
zcat ${SB_PATCHDIR}/${NAME}-4.1.80-nsplugins-paths.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.1-home-icon-slk.patch.gz | patch -p2 -E --backup --verbose

# backwards compatibility hack for a config option changed by our old
# konsole-session patch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-konsole-activetabindex.patch

# fix disabling automatic spell checking in the Konqueror UI (kde#228593)
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-konqueror-kde\#228593.patch.gz | patch -p2 -E --backup --verbose

# Password & User account becomes non responding
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.4-bz\#609039-chfn-parse.patch

## upstream patches
# https://projects.kde.org/projects/kde/kdebase/kde-baseapps/repository/revisions/12bbb3bf76bc3d12d8a08e347216b88274007f17 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.3-nsplugins_sdk_headers.patch
# https://projects.kde.org/projects/kde/kdebase/kde-baseapps/repository/revisions/b7e487550a29b35072e24adaf4df6eb48264129d
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.6.3-nsplugins_flash.patch 

# Mandriva

#trunk patches

set +e +o pipefail
