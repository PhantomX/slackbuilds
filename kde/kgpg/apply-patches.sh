
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# add support for gpg2 to kgpg
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/kgpg-4.8.80-gpg2.patch

set +e +o pipefail
