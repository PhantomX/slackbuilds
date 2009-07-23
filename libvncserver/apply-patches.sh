  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-0.9.7-system_minilzo.patch.gz | patch -p1 -E --backup --verbose || exit 1
find . -name minilzo\* -exec rm -f {} \;
zcat ${SB_PATCHDIR}/${NAME}-0.9.1-multilib.patch.gz | patch -p1 -E --backup --verbose || exit 1
# safer LINUX platform detection (from opensuse)
zcat ${SB_PATCHDIR}/${NAME}-LINUX.patch.gz | patch -p0 -E --backup --verbose || exit 1

## upstream patches
zcat ${SB_PATCHDIR}/${NAME}-0.9.1-close_server_socket.patch.gz | patch -p1 -E --backup --verbose || exit 1
