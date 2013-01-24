
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/joystick-1.4.4-build.patch

set +e +o pipefail
