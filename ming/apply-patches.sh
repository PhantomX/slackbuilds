
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ming-multilib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ming-perl.patch

set +e +o pipefail
