
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.8-menu.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.9-fribidi.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.8-deprecated.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
