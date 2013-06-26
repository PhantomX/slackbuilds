
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
  echo "Applying ${patch}"
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Internal debug
#ApplyPatch openssh-5.9p1-wIm.patch
ApplyPatch openssh-6.2p1-coverity.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1872
ApplyPatch openssh-6.2p1-fingerprint.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1894
ApplyPatch openssh-5.8p1-getaddrinfo.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1889
ApplyPatch openssh-5.8p1-packet.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1641 (WONTFIX)
ApplyPatch openssh-6.2p1-role-mls.patch
sed 's|-lfipscheck||g' ${SB_PATCHDIR}/openssh-6.2p1-ldap.patch | patch -p1 -E --backup --verbose
# https://bugzilla.mindrot.org/show_bug.cgi?id=1644
ApplyPatch openssh-5.2p1-allow-ip-opts.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1701
ApplyPatch openssh-5.9p1-randclean.patch
ApplyPatch openssh-5.8p1-glob.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1893
ApplyPatch openssh-5.8p1-keyperm.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1329 (WONTFIX)
ApplyPatch openssh-5.8p2-remove-stale-control-socket.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1925
ApplyPatch openssh-5.9p1-ipv6man.patch
ApplyPatch openssh-5.8p2-sigpipe.patch
ApplyPatch openssh-6.1p1-askpass-ld.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1789
ApplyPatch openssh-5.5p1-x11.patch
ApplyPatch openssh-5.6p1-exit-deadlock.patch
ApplyPatch openssh-5.1p1-askpass-progress.patch
ApplyPatch openssh-4.3p2-askpass-grab-info.patch
ApplyPatch openssh-5.1p1-scp-manpage.patch
ApplyPatch openssh-5.9p1-edns.patch
ApplyPatch openssh-5.8p1-localdomain.patch
ApplyPatch openssh-5.9p1-chinfo.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1890 (WONTFIX) need integration to prng helper which is discontinued :)
ApplyPatch openssh-6.2p1-entropy.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1640
ApplyPatch openssh-6.2p1-vendor.patch
# make aes-ctr ciphers use EVP engines such as AES-NI from OpenSSL
ApplyPatch openssh-5.9p1-ctr-evp-fast.patch
# add cavs test binary for the aes-ctr
ApplyPatch openssh-6.2p1-ctr-cavstest-slk.patch
# obsolete RequiredAuthentications options
ApplyPatch openssh-6.2p1-required-authentications.patch
ApplyPatch openssh-6.2p1-modpipe-cflags.patch
# make sftp's libedit interface marginally multibyte aware (#841771)
ApplyPatch openssh-6.2p2-sftp-multibyte.patch

set +e +o pipefail

