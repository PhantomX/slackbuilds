
SB_PATCHDIR=${CWD}/patches

set -e -o pipefail

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch 
zcat ${SB_PATCHDIR}/${NAME}-4.1.80-nsplugins-paths.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.1-home-icon-slk.patch.gz | patch -p1 -E --backup --verbose

# backwards compatibility hack for a config option changed by our old
# konsole-session patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-konsole-activetabindex.patch

# fix disabling automatic spell checking in the Konqueror UI (kde#228593)
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-konqueror-kde\#228593.patch.gz | patch -p1 -E --backup --verbose

# Password & User account becomes non responding
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.3.4-bz\#609039-chfn-parse.patch

# Mandriva

#trunk patches

## upstream patches

set +e +o pipefail
