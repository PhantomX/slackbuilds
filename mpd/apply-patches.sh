
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.18.8-systemd209.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-ThreadInputStream-add-assertions.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-ThreadInputStream-call-ThreadRead-inside-the-thread-.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0003-Makefile.am-distribute-systemd-mpd.socket.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
