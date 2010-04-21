
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Support-both-the-0.2.x-and-the-0.1.x-versions-of-the.patch

set +e +o pipefail
