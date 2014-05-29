
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-librevenge-stream-is-optional-don-t-depend-on-it.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-librevenge-stream-is-optional-don-t-depend-on-it.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
