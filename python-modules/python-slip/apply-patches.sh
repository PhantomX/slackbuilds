
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Run without selinux
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-noselinux.patch

set +e +o pipefail
