
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/glew-1.5.2-makefile.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/glew-1.5.2-add-needed.patch

set +e +o pipefail
