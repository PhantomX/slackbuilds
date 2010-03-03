
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-4.4.0-slk-knetworkconf.patch.gz | patch -p1 -E --backup -z .slk --verbose
zcat ${SB_PATCHDIR}/${NAME}-4.2.85-printing.patch.gz | patch -p1 -E --backup --verbose

## upstream patches
# https://bugs.kde.org/show_bug.cgi?id=219751#c9
zcat ${SB_PATCHDIR}/${NAME}-4.3.95-system_config_printer_fix.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
