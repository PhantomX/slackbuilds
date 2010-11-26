
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-4.2.2-workaround-kolorpaintcrash.patch.gz | patch -p1 -E --backup --verbose

## upstream patches
# http://bugs.kde.org/254283
# http://websvn.kde.org/?view=revision&revision=1194513
patch -p4 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.5.3-pluginloader.patch

set +e +o pipefail
