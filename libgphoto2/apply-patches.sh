
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libgphoto2-pkgcfg.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libgphoto2-storage.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libgphoto2-ixany.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libgphoto2-maxentries.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libgphoto2-device-return.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
