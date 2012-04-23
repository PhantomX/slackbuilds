
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Internal debug
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-wIm.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-coverity.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1872
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-fingerprint.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1894
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-getaddrinfo.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1889
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-packet.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=983
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-2auth.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-required-authentications.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1641 (WONTFIX)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-role.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1663
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-akc.patch
sed 's|-lfipscheck||g' ${SB_PATCHDIR}/openssh-5.9p1-ldap.patch | patch -p1 -E --backup --verbose
# https://bugzilla.mindrot.org/show_bug.cgi?id=1668
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-keygen.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1644
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.2p1-allow-ip-opts.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1701
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-randclean.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1636
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-log-in-chroot.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-glob.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1893
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-keyperm.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1329 (WONTFIX)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p2-remove-stale-control-socket.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1925
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-ipv6man.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1789
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.5p1-x11.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.6p1-exit-deadlock.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-askpass-progress.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-4.3p2-askpass-grab-info.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.1p1-scp-manpage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-edns.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.8p1-localdomain.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-chinfo.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1890 (WONTFIX) need integration to prng helper which is discontinued :)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-entropy.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1640
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-vendor.patch
# make aes-ctr ciphers use EVP engines such as AES-NI from OpenSSL
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-ctr-evp-fast.patch
# add cavs test binary for the aes-ctr
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssh-5.9p1-ctr-cavstest-slk.patch

set +e +o pipefail

