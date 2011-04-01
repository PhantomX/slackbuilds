
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .system_minilzo --verbose -i ${SB_PATCHDIR}/${NAME}-0.9.8-system_minilzo.patch
find . -name minilzo\* -exec rm -f {} \;
zcat ${SB_PATCHDIR}/${NAME}-0.9.1-multilib.patch.gz | patch -p1 -E --backup --verbose
# safer LINUX platform detection (from opensuse)
#zcat ${SB_PATCHDIR}/${NAME}-LINUX.patch.gz | patch -p0 -E --backup --verbose

## upstream patches

set +e +o pipefail
