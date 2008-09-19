
SB_PATCHDIR=${CWD}/patches

# Patch to make gnokii use "htmlview" instead of "mozilla" as default browser
zcat ${SB_PATCHDIR}/${NAME}-htmlview.patch.gz | patch -p0 -E --backup --verbose || exit 1
# Patch to remove port locking and apply the system-wide /usr/sbin directory
# to the path instead of the default /usr/local
zcat ${SB_PATCHDIR}/${NAME}-config.patch.gz | patch -p0 -E --backup --verbose || exit 1
