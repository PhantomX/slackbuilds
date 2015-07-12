
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mtools-3.9.6-config.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/01-607426-support-zip-files-in-uz.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
