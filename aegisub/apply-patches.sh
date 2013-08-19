
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/wxgtk2.9.5.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
