
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
## upstream patches
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-KCM-Adapters-Adapt-to-changes-in-libbluedevil.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-Bluedevil-daemon-Save-and-restore-adapters-state.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-daemon-Use-new-functions-for-restoring-adapters-stat.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0004-Monolithic-Don-t-go-online-on-startup-when-there-is-.patch

set +e +o pipefail
