
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-typo-in-debug-messages.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-fix-include-statements-for-large-file-support-on-32-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Add-support-for-Green-Magenta-and-Yellow-Blue-anagly.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
