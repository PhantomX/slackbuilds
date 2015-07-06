
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
PATCH_DRYRUN=${PATCH_DRYRUN:-NO}

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
# https://bugzilla.mindrot.org/show_bug.cgi?id=1894
#ApplyPatch openssh-5.8p1-getaddrinfo.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1889
ApplyPatch openssh-5.8p1-packet.patch

if [ "${SB_PAM}" = "YES" ] ;then
( cd ${ASRCDIR}
  # --- pam_ssh-agent ---
  # make it build reusing the openssh sources
  ApplyPatch pam_ssh_agent_auth-0.9.3-build.patch
  # check return value of seteuid()
  ApplyPatch pam_ssh_agent_auth-0.9.2-seteuid.patch
  # explicitly make pam callbacks visible
  ApplyPatch pam_ssh_agent_auth-0.9.2-visibility.patch
  # don't use xfree (#1024965)
  ApplyPatch pam_ssh_agent_auth-0.9.3-no-xfree.patch
  # use SSH_DIGEST_* for fingerprint hashes
  ApplyPatch pam_ssh_agent_auth-0.9.3-fingerprint-hash.patch -p2
  # update to current version of agent structure
  ApplyPatch pam_ssh_agent_auth-0.9.3-agent_structure.patch -p2
  rm -f $(cat ${CWD}/pam_ssh_agent-rmheaders)
)
fi

echo "Applying openssh-6.6p1-ldap.patch"
sed 's|-lfipscheck||g' ${SB_PATCHDIR}/openssh-6.7p1-ldap.patch | ${PATCHCOM}
# https://bugzilla.mindrot.org/show_bug.cgi?id=1644
ApplyPatch openssh-5.2p1-allow-ip-opts.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1701
ApplyPatch openssh-5.9p1-randclean.patch
ApplyPatch openssh-5.8p1-glob.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1893
ApplyPatch openssh-6.6p1-keyperm.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1329 (WONTFIX)
ApplyPatch openssh-5.8p2-remove-stale-control-socket.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1925
ApplyPatch openssh-5.9p1-ipv6man.patch
ApplyPatch openssh-5.8p2-sigpipe.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1789
ApplyPatch openssh-5.5p1-x11.patch
ApplyPatch openssh-5.1p1-askpass-progress.patch
ApplyPatch openssh-4.3p2-askpass-grab-info.patch
ApplyPatch openssh-5.8p1-localdomain.patch
ApplyPatch openssh-6.3p1-chinfo.patch -z .chinfo
[ "${SB_PAM}" = "YES" ] || sed -i -e '/^UsePAM yes/d' sshd_config
# https://bugzilla.mindrot.org/show_bug.cgi?id=1890 (WONTFIX) need integration to prng helper which is discontinued :)
echo "Applying openssh-6.6p1-entropy.patch"
sed 's| port-linux-sshd\.o||g' ${SB_PATCHDIR}/openssh-6.6p1-entropy.patch | ${PATCHCOM}
# https://bugzilla.mindrot.org/show_bug.cgi?id=1640
ApplyPatch openssh-6.2p1-vendor.patch
# warn users for unsupported UsePAM=no (#757545)
[ "${SB_PAM}" = "YES" ] && ApplyPatch openssh-6.1p1-log-usepam-no-slk.patch
# make aes-ctr ciphers use EVP engines such as AES-NI from OpenSSL
ApplyPatch openssh-6.3p1-ctr-evp-fast.patch
# add cavs test binary for the aes-ctr
ApplyPatch openssh-6.6p1-ctr-cavstest-slk.patch
# add SSH KDF CAVS test driver
ApplyPatch openssh-6.7p1-kdf-cavs-chinfo.patch

# Run ssh-copy-id in the legacy mode when SSH_COPY_ID_LEGACY variable is set (#969375
ApplyPatch openssh-6.4p1-legacy-ssh-copy-id.patch
# Use tty allocation for a remote scp (#985650)
ApplyPatch openssh-6.4p1-fromto-remote.patch
# set a client's address right after a connection is set
# http://bugzilla.mindrot.org/show_bug.cgi?id=2257
ApplyPatch openssh-6.6p1-set_remote_ipaddr.patch
# apply RFC3454 stringprep to banners when possible
# https://bugzilla.mindrot.org/show_bug.cgi?id=2058
# slightly changed patch from comment 10
ApplyPatch openssh-6.6.1p1-utf8-banner.patch
# use different values for DH for Cisco servers (#1026430)
#ApplyPatch openssh-6.6.1p1-cisco-dh-keys.patch
# scp file into non-existing directory (#1142223)
ApplyPatch openssh-6.6.1p1-scp-non-existing-directory.patch
# Config parser shouldn't accept ip/port syntax (#1130733)
ApplyPatch openssh-6.6.1p1-ip-port-config-parser.patch
# restore tcp wrappers support, based on Debian patch
# https://lists.mindrot.org/pipermail/openssh-unix-dev/2014-April/032497.html
ApplyPatch openssh-6.7p1-debian-restore-tcp-wrappers.patch
# apply upstream patch and make sshd -T more consistent (rh#1187521)
ApplyPatch openssh-6.8p1-sshdT-output.patch
# fix ssh-copy-id on non-sh shells (rh#1045191)
ApplyPatch openssh-6.8p1-fix-ssh-copy-id-on-non-sh-shell.patch
# AArch64 has seccomp support since 3.19 kernel (rh#1195065)
ApplyPatch openssh-6.7p1-seccomp-aarch64.patch
# Solve issue with ssh-copy-id and keys without trailing newline (rh#1093168)
ApplyPatch openssh-6.7p1-ssh-copy-id-truncated-keys.patch
# Add sftp option to force mode of created files (rh#1191055)
ApplyPatch openssh-6.7p1-sftp-force-permission.patch
# Memory problems
# https://bugzilla.mindrot.org/show_bug.cgi?id=2401
ApplyPatch openssh-6.8p1-memory-problems.patch

ApplyPatch openssh-6.7p1-coverity.patch

set +e +o pipefail

