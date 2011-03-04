
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# patch -p1 -E --backup -z .dricore --verbose -izcat ${SB_PATCHDIR}/mesa-7.1-link-shared.patch
# Fedora
patch -p1 -E --backup -z .da --verbose -i ${SB_PATCHDIR}/mesa-no-mach64.patch
patch -p1 -E --backup -z .nouveau --verbose -i ${SB_PATCHDIR}/nouveau-legacy-enable.patch
zcat ${SB_PATCHDIR}/mesa-7.6-hush-vblank-warning.patch.gz | patch -p1 -E --backup --verbose
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-7.10-swrastg.patch

sed -i -e '/nouveau_pushbuf.h/a#include "nvc0_pushbuf.h"' \
  src/mesa/drivers/dri/nouveau/nouveau_driver.h || exit 1
sed -i -e '/nouveau_pushbuf.h/a#include "nouveau/nv04_pushbuf.h"' \
  src/gallium/drivers/nouveau/nouveau_winsys.h \
  src/gallium/drivers/nvfx/nv04_2d.c || exit 1
set +e +o pipefail
