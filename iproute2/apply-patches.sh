  
SB_PATCHDIR=${CWD}/patches

# Fix up path to bdb
zcat ${SB_PATCHDIR}/${NAME}.dbpath.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
# Fix up iptables lib path
zcat ${SB_PATCHDIR}/${NAME}.iptablespath.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6.9-kernel.patch.gz | patch -p2 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/iproute-ip-man.patch.gz | patch -p2 -E --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-2.6.25-segfault.patch.gz | patch -p2 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-sharepath.patch.gz | patch -p2 -E --backup --verbose || exit 1
