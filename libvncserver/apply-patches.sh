
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup -z .system_minilzo --verbose -i ${SB_PATCHDIR}/${PNAME}-0.9.10-system_minilzo.patch
rm -f common/lzodefs.h common/lzoconf.h common/minilzo.h common/minilzo.c
zcat ${SB_PATCHDIR}/${NAME}-0.9.1-multilib.patch.gz | patch -p1 -E --backup --verbose

## upstream patches

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
