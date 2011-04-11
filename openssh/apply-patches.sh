
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-wIm.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-packet.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-entropy.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1640
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-vendor.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-authorized-keys-command.patch
sed 's|-lfipscheck||g' ${SB_PATCHDIR}/openssh-5.8p1-ldap.patch | patch -p1 -E --backup --verbose
# https://bugzilla.mindrot.org/show_bug.cgi?id=1668
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.6p1-keygen.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1644
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.2p1-allow-ip-opts.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1701
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-randclean.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1636
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-log-in-chroot.patch
#https://bugzilla.mindrot.org/show_bug.cgi?id=1780
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-kuserok.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-glob.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-pwchange.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1789
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.5p1-x11.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.6p1-exit-deadlock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-askpass-progress.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-4.3p2-askpass-grab-info.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-scp-manpage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.2p1-edns.patch

set +e +o pipefail

