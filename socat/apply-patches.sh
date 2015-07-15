
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/socat.git-8c6ec94d8919479704cc564dcf96d47831693d2b.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
