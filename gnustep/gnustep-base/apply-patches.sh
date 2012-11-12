
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://savannah.gnu.org/bugs/?37609
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libxml2.patch

set +e +o pipefail
