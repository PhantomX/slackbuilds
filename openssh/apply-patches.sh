
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1640
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.2p1-vendor.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.6p1-authorized-keys-command.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.6p1-ldap-slk.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1668
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.6p1-keygen.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-4.3p1-fromto-remote.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1636
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-log-in-chroot.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.6p1-exit-deadlock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-askpass-progress.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-4.3p2-askpass-grab-info.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1644
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.2p1-allow-ip-opts.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-scp-manpage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.2p1-edns.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1701
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.3p1-randclean.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.5p1-x11.patch

set +e +o pipefail

