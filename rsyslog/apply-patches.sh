
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-7.4.1-sd-service-slk.patch

### Arch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
