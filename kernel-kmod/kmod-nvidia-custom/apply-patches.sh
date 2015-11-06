
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/310.19-unified-arch.patch
# https://devtalk.nvidia.com/default/topic/877365/linux/355-11-linux-4-3-rc1-build-error/
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/nvidia-linux-4.3.patch

set +e +o pipefail
