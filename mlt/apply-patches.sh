
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-segmentation-fault-at-exit-by-calling-av_lockmgr.patch

set +e +o pipefail
