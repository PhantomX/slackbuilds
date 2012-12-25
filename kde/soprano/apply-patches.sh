
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-No-qDebug-output-in-non-debug-modes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-override-QT_USE_FILE-to-fix-include-order.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Fix-100-CPU-usage-when-killing-virtuoso.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Check-return-values-from-write-calls.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-Fix-crashes-due-to-using-the-same-QUrls-in-multiple-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0008-Client-Cache-the-current-bindings.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0009-Optimize-sending-of-LiteralValue-over-the-socket.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-Avoid-crash-on-destruction-of-ClientModel-if-nepomuk.patch

set +e +o pipefail
