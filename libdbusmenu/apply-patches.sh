
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.2.8-no-gobject-introspection.patch

set +e +o pipefail
