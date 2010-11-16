
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#patch -p1 --backup -z .multilib --verbose -i ${SB_PATCHDIR}/${NAME}-4.7.4-multilib.patch

set +e +o pipefail
