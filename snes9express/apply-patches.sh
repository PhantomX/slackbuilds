
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/snes9express-1.43-as-needed.patch

set +e +o pipefail
