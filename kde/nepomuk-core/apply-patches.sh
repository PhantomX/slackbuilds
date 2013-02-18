
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-fileindexer-fix-taglib-bitrate-units.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-fileindexer-initialize-objects-in-correct-order.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-IndexScheduler-Connect-both-the-queues-together.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0005-ResourceWatcher-Emit-the-current-signals-in-property.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0007-Resource-Do-not-auto-update-the-cache-by-default.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0010-Revert-BasicIndexingQueue-Use-stacks-instead-of-queu.patch

set +e +o pipefail
