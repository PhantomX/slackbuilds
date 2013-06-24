
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.8.1-utf8-scroll.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.9.0-nobool.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.9.0-lines-fix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/conky-1.9.0-update-when-message-count-decreases.patch

set +e +o pipefail
