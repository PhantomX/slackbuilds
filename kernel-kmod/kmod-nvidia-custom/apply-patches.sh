
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/310.19-unified-arch.patch
# https://devtalk.nvidia.com/default/topic/632643/linux/-331-20-whql-long-term-driver-discussion/post/4004664/#4004664
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nvidia-linux-user_ns.patch

set +e +o pipefail
