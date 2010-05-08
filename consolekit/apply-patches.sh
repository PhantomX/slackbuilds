
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/nodaemon.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/reorder-initialization.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/consolekit-0.2.10-cleanup_console_tags.patch

set +e +o pipefail
