
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.10-avoid-close-button-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.10-avoid-decline-deleting-file-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.10-avoid-unknown-image-save-crash.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.1.10-avoid-load-text-file-crash.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
