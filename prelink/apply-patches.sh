
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patches from openSUSE
patch -p0 -E --backup -z .cool --verbose -i ${SB_PATCHDIR}/${NAME}-make_it_cool.patch

set +e +o pipefail
