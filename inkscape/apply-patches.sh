
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-update-to-new-libwpg.patch
### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ime-placement.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
