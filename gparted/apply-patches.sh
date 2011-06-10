
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gparted-parted30-autoconf-fmt.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gparted-parted30-autoconf.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gparted-parted30-build.patch

set +e +o pipefail
