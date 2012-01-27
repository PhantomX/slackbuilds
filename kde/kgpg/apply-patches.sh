
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# add support for gpg2 to kgpg
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/kdeutils-4.7.1-gpg2.patch

set +e +o pipefail
