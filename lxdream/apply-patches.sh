
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .glib231 --verbose -i ${SB_PATCHDIR}/${NAME}-glib231.patch

set +e +o pipefail
