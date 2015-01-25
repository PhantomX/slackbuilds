
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.0-systemd209.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.6.1-libinput08.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-libinput-device-use-the-new-merged-scroll-events.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
