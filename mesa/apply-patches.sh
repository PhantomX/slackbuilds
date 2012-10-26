
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-8.0-nouveau-tfp-blacklist.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-8.0.1-fix-16bpp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-9.0-12-gd56ee24.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mesa-9.0-wayland-0.99.patch

set +e +o pipefail
