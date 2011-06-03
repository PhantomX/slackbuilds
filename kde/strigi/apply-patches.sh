
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .multilib --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.5-multilib.patch
patch -p1 -E --backup -z .no_rpm --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.5-no_rpm.patch

## upstream patches

set +e +o pipefail
