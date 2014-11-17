
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
ApplyPatch openssh-6.6.1p1-coverity.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1872
ApplyPatch openssh-6.3p1-fingerprint.patch
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
)
fi

echo "Applying openssh-6.6p1-ldap.patch"
sed 's|-lfipscheck||g' ${SB_PATCHDIR}/openssh-6.6p1-ldap.patch | ${PATCHCOM}
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
ApplyPatch openssh-6.1p1-askpass-ld.patch
# https://bugzilla.mindrot.org/show_bug.cgi?id=1789
ApplyPatch openssh-5.5p1-x11.patch
ApplyPatch openssh-5.6p1-exit-deadlock.patch
ApplyPatch openssh-5.1p1-askpass-progress.patch
ApplyPatch openssh-4.3p2-askpass-grab-info.patch
ApplyPatch openssh-5.1p1-scp-manpage.patch
ApplyPatch openssh-5.9p1-edns.patch
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
# obsolete RequiredAuthentications options
ApplyPatch openssh-6.2p1-required-authentications.patch

# Run ssh-copy-id in the legacy mode when SSH_COPY_ID_LEGACY variable is set (#969375
ApplyPatch openssh-6.4p1-legacy-ssh-copy-id.patch
# Use tty allocation for a remote scp (#985650)
ApplyPatch openssh-6.4p1-fromto-remote.patch
# Try CLOCK_BOOTTIME with fallback (#1091992)
ApplyPatch openssh-6.4p1-CLOCK_BOOTTIME.patch
# Prevents a server from skipping SSHFP lookup and forcing a new-hostkey
# dialog by offering only certificate keys. (#1081338)
ApplyPatch openssh-6.6p1-CVE-2014-2653.patch
# OpenSSH 6.5 and 6.6 sometimes encode a value used in the curve25519 key exchange incorrectly
# Disable the curve25519 KEX when speaking to OpenSSH 6.5 or 6.6
ApplyPatch openssh-5618210618256bbf5f4f71b2887ff186fd451736.patch
# standardise on NI_MAXHOST for gethostname() string lengths (#1051490)
ApplyPatch openssh-6.6.1p1-NI_MAXHOST.patch
# set a client's address right after a connection is set
# http://bugzilla.mindrot.org/show_bug.cgi?id=2257
ApplyPatch openssh-6.6p1-set_remote_ipaddr.patch
# apply RFC3454 stringprep to banners when possible
# https://bugzilla.mindrot.org/show_bug.cgi?id=2058
# slightly changed patch from comment 10
ApplyPatch openssh-6.6.1p1-utf8-banner.patch
# don't consider a partial success as a failure
# https://bugzilla.mindrot.org/show_bug.cgi?id=2270
ApplyPatch openssh-6.6.1p1-partial-success.patch
# Ignore SIGXFSZ in postauth monitor
# https://bugzilla.mindrot.org/show_bug.cgi?id=2263
ApplyPatch openssh-6.6.1p1-ignore-SIGXFSZ-in-postauth.patch

set +e +o pipefail

