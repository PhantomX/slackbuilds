
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${PNAME}-1.2.7-CFLAGS.patch.gz | patch -p1 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.2.0-headers.patch
zcat ${SB_PATCHDIR}/${PNAME}-1.1.1-pkgconfig.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${PNAME}-1.4.5-libv4l2.patch
zcat ${SB_PATCHDIR}/${PNAME}-1.2.8-tweak.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
