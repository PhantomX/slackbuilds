
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-runpatch.patch.gz | patch -p0 -E --backup --verbose
# 'decoration' plugin changed name to 'decor' in Compiz 0.9
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1-compiz09_decor.patch
# 'Display' changed to 'Screen' in compizconfig-python 0.9
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1-compiz09_screen.patch
# --ignore-desktop-hints parameter no longer exists in Compiz 0.9
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.1-compiz09_desktop_hints.patch

set +e +o pipefail
