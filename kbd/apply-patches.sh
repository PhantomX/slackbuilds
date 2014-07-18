
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/nl.euro.diff.gz | patch -p1 --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15-keycodes-man.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15-unicode_start.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15.3-dumpkeys-man.patch
# Patch4: fixes decimal separator in Swiss German keyboard layout, rhbz 882529
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15.5-sg-decimal-separator.patch
# adds xkb and legacy keymaps subdirs to loadkyes search path, rhbz 1028207 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15.5-loadkeys-search-path.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
