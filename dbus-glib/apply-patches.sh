
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/broken-xml.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-proxy-signals-once.patch.gz | patch -p1 -E --backup --verbose || exit 1
# https://bugs.freedesktop.org/show_bug.cgi?id=14429
zcat ${SB_PATCHDIR}/${NAME}-0.73-ignore-namespaces.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.74-set-default-timeout-for-proxy.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.74-export-getall.patch.gz | patch -p1 -E --backup --verbose || exit 1
