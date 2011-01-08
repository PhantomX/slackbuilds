
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-InstallPrinterDrivers-debug.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-mfg-mdl.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-NPTLpdQueue.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-uint32.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-compiz-rename.patch

set +e +o pipefail
