
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .system_minilzo --verbose -i ${SB_PATCHDIR}/${PNAME}-0.9.8.2-system_minilzo.patch
rm -f common/lzodefs.h common/lzoconf.h commmon/minilzo.h common/minilzo.c
zcat ${SB_PATCHDIR}/${NAME}-0.9.1-multilib.patch.gz | patch -p1 -E --backup --verbose
# safer LINUX platform detection (from opensuse)
zcat ${SB_PATCHDIR}/${NAME}-LINUX.patch.gz | patch -p0 -E --backup --verbose

## upstream patches

set +e +o pipefail
