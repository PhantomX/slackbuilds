
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/nl.euro.diff.gz | patch -p1 --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15-po.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15-keycodes-man.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15-unicode_start.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15-resizecon-x86_64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kbd-1.15-defkeymap.patch

set +e +o pipefail
