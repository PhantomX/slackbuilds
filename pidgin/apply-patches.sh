
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.9-valgrind.patch
# http://hg.pidgin.im/pidgin/main/rev/2b41ba1fde8a
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-send-video-enum.patch
# http://hg.pidgin.im/pidgin/main/rev/b52be4fef1de
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-gst-references.patch
# http://hg.pidgin.im/pidgin/main/rev/6b4576edf2a6
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-add-dtmf-support.patch
# http://hg.pidgin.im/pidgin/main/rev/2415067473ba
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-gstreamer1.patch
# http://hg.pidgin.im/pidgin/main/rev/fcecf7f838e2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-rtp-tcp.patch
# http://hg.pidgin.im/pidgin/main/rev/a0906e7a6bae
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-rtp-encryption.patch
# http://hg.pidgin.im/pidgin/main/rev/5f5abd63c305
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-rtcp-mux.patch
# http://hg.pidgin.im/pidgin/main/rev/88b09a22b7c4
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-signal-pair-established.patch
# http://hg.pidgin.im/pidgin/main/rev/a52798da5cfa
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-farstream027.patch
# http://hg.pidgin.im/pidgin/main/rev/a071658c3725
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-xfer-rw-file.patch
# http://hg.pidgin.im/pidgin/main/rev/8e4fa54f1662
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-unlink-source.patch
# http://hg.pidgin.im/pidgin/main/rev/7767aaeade64
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-init-media-optional.patch
# http://hg.pidgin.im/pidgin/main/rev/d729a9b21265
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-private-media.patch
# http://hg.pidgin.im/pidgin/main/rev/4fe1034f3dce
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pidgin-2.10.11-application-media.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
