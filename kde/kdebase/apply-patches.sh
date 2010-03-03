
SB_PATCHDIR=${CWD}/patches

set -e -o pipefail

zcat ${SB_PATCHDIR}/${NAME}-4.1.80-nsplugins-paths.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.1.70-konsole-session.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.1-home-icon-slk.patch.gz | patch -p1 -E --backup --verbose

# fix disabling automatic spell checking in the Konqueror UI (kde#228593)
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-konqueror-kde\#228593.patch.gz | patch -p1 -E --backup --verbose

# Mandriva
zcat ${SB_PATCHDIR}/${NAME}-4.3.98-fix-execute-scripts.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.4.0-folderview-icon-text.patch.gz | patch -p0 -E --backup --verbose

## upstream patches

set +e +o pipefail
