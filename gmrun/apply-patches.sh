
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-gmrunrc.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-0.9.2-gcc43.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gmrun-0.9.2-mousewheel.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gmrun-0.9.2-f12.patch

set +e +o pipefail
