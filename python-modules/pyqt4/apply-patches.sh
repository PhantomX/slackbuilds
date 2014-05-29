
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix multilib conflict because of timestamp
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/PyQt-x11-gpl-4.9.5-timestamp_multilib.patch

## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/qreal_float_support.diff

set +e +o pipefail
