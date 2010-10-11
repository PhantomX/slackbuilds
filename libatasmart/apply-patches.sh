
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=25543
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-uninitialized-var.patch

set +e +o pipefail
