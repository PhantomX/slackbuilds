
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libdrm-make-dri-perms-okay.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libdrm-2.4.0-no-bc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libdrm.uint32_t.diff

set +e +o pipefail
