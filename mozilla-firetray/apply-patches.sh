
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patch3 : use our own icons instead of the provided ones, except the newmail one
#          http://code.google.com/p/firetray/issues/detail?id=109
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.3.1-use-our-icons.patch

set +e +o pipefail
