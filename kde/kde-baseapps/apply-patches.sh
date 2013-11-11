
SB_PATCHDIR=${CWD}/patches

set -e -o pipefail

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kdebase.patch 
zcat ${SB_PATCHDIR}/kdebase-4.1.80-nsplugins-paths.patch.gz | patch -p2 -E --backup --verbose
zcat ${SB_PATCHDIR}/kdebase-4.2.1-home-icon-slk.patch.gz | patch -p2 -E --backup --verbose

# Display menubar by default on dolphin
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.8.1-dolphin-menubar.patch

# fix disabling automatic spell checking in the Konqueror UI (kde#228593)
zcat ${SB_PATCHDIR}/kdebase-4.4.0-konqueror-kde\#228593.patch.gz | patch -p2 -E --backup --verbose

# add x-scheme-handler/http for konqueror so it can be set
# as default browser in GNOME
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.9.2-konqueror-mimetyp.patch

## upstream patches
# some post v4.11.3 commits, one for regression
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-Bug-287983-Dolphin-truncates-tooltip-information.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Revert-Files-passed-as-arguments-Ignore-unsupported-.patch

#trunk patches

set +e +o pipefail
