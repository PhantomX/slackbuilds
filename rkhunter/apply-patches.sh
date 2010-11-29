
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# From fedora without rpm.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.3.8-slkconfig.patch

set +e +o pipefail
