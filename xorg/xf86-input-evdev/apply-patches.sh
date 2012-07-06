
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-inverted-horizontal-scroll-46205.patch
# Bug 805902 - Scrollwheels on tablets are broken
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Allow-relative-scroll-valuators-on-absolute-devices.patch
# Don't leak mtdev data
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Release-mtdev-data-whenever-we-close-the-fd.patch

set +e +o pipefail
