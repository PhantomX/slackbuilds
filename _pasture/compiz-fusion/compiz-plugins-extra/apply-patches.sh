
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libnotify-070-fix.diff

set +e +o pipefail
