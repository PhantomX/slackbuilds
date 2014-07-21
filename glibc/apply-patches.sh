
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_VERBOSE_OPT
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch -p1 -s -F1 --backup ${PATCH_VERBOSE_OPT}"

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

# Use old-style locale directories rather than a single (and strangely
# formatted) /usr/lib/locale/locale-archive file:
ApplyPatch glibc.locale.no-archive.diff.gz
# The is_IS locale is causing a strange error about the "echn" command
# not existing.  This patch reverts is_IS to the version shipped in
# glibc-2.5:
ApplyPatch is_IS.diff.gz
# Fix NIS netgroups:
ApplyPatch glibc.nis-netgroups.diff.gz
# Support ru_RU.CP1251 locale:
ApplyPatch glibc.ru_RU.CP1251.diff.gz
# http://sources.redhat.com/bugzilla/show_bug.cgi?id=411
# http://sourceware.org/ml/libc-alpha/2009-07/msg00072.html
ApplyPatch glibc-__i686.patch

if [ "${SB_BOOTSTRP}" = "YES" ] ;then
  # Multilib - Disable check for forced unwind (Patch from eglibc) since we
  # do not have a multilib glibc yet to link to;
  ApplyPatch glibc.pthread-disable-forced-unwind-check.diff
fi

### Gentoo
( SB_PATCHDIR=patches

  ApplyPatch 00_all_0001-disable-ldconfig-during-install.patch
  ApplyPatch 00_all_0002-workaround-crash-when-handling-signals-in-static-PIE.patch
  ApplyPatch 00_all_0003-make-fortify-logic-checks-less-angry.patch
  ApplyPatch 00_all_0004-Fix-localedef-segfault-when-run-under-exec-shield-Pa.patch
  ApplyPatch 00_all_0005-reload-etc-resolv.conf-when-it-has-changed.patch
  ApplyPatch 00_all_0006-nptl-support-thread-stacks-that-grow-up.patch
  ApplyPatch 00_all_0007-rtld-do-not-ignore-arch-specific-CFLAGS.patch
  ApplyPatch 00_all_0008-nptl-handle-EAGAIN-with-some-futex-operations.patch
  ApplyPatch 00_all_0009-gentoo-support-running-tests-under-sandbox.patch
  ApplyPatch 00_all_0010-gentoo-disable-building-in-timezone-subdir.patch
  ApplyPatch 00_all_0011-arm-fix-PIC-vs-SHARED-typos.patch
  ApplyPatch 00_all_0012-posix_spawn_file_actions_addopen-needs-to-copy-the-p.patch
  ApplyPatch 00_all_0013-posix_spawn_faction_addopen-Add-missing-string.h-inc.patch
  ApplyPatch 00_all_0014-Fix-sign-of-input-to-bsloww1-BZ-16623.patch
)

## Fedora
# Needs to be sent upstream
ApplyPatch glibc-fedora-getrlimit-PLT.patch
ApplyPatch glibc-fedora-include-bits-ldbl.patch

# Needs to be sent upstream
ApplyPatch glibc-rh841318.patch

ApplyPatch glibc-fedora-nptl-linklibc.patch
ApplyPatch glibc-fedora-i386-tls-direct-seg-refs.patch
ApplyPatch glibc-fedora-uname-getrlimit.patch
ApplyPatch glibc-fedora-elf-rh737223.patch
ApplyPatch glibc-fedora-elf-ORIGIN.patch
ApplyPatch glibc-fedora-elf-init-hidden_undef.patch

ApplyPatch glibc-rh911307.patch
ApplyPatch glibc-rh952799.patch

# Allow applications to call pthread_atfork without libpthread.so.
ApplyPatch glibc-rh1013801.patch

# http://sourceware.org/ml/libc-alpha/2012-12/msg00103.html
ApplyPatch glibc-rh697421.patch
ApplyPatch glibc-rh757881.patch
ApplyPatch glibc-rh741105.patch
# Upstream BZ 14247
ApplyPatch glibc-rh827510.patch
# Upstream BZ 13028
ApplyPatch glibc-rh841787.patch
# Upstream BZ 14185
ApplyPatch glibc-rh819430.patch
# Fix nscd to use permission names not constants.
ApplyPatch glibc-rh1025126.patch
ApplyPatch glibc-rh1070416.patch

## Mandriva
ApplyPatch glibc-2.11.1-localedef-archive-follow-symlinks.patch 
ApplyPatch glibc-2.9-ldd-non-exec.patch.gz
ApplyPatch glibc-2.17-nss-upgrade.patch
ApplyPatch glibc-2.19-compat-EUR-currencies.patch
ApplyPatch glibc-2.9-nscd-no-host-cache.patch.gz
ApplyPatch glibc-2.3.2-tcsetattr-kernel-bug-workaround.patch.gz
ApplyPatch glibc-2.10.1-biarch-cpp-defines.patch.gz
ApplyPatch glibc-2.6-nice_fix.patch
ApplyPatch glibc-2.8-ENOTTY-fr-translation.patch.gz
ApplyPatch glibc-2.3.5-biarch-utils.patch.gz
ApplyPatch glibc-2.16-multiarch.patch
ApplyPatch glibc-2.3.6-pt_BR-i18nfixes.patch.gz

### Arch
ApplyPatch glibc-2.19-xattr_header.patch
ApplyPatch glibc-2.19-fix-sign-in-bsloww1-input.patch

## master
ApplyPatch 0001-Avoid-comma-operator-warnings.patch
ApplyPatch 0001-Fix-tst-sscanf-and-tst-swscanf-on-64-bit.patch
ApplyPatch 0001-BZ-16447-Fix-ldbl-128-expl-implementation.patch
ApplyPatch 0001-Mark-nscd-service-as-forking-in-systemd-service-file.patch
ApplyPatch 0001-nscd-Improved-support-for-tracking-startup-failure-i.patch
ApplyPatch 0001-Provide-correct-buffer-length-to-netgroup-queries-in.patch
ApplyPatch 0001-Account-for-alloca-use-when-collecting-interface-add.patch
ApplyPatch 0001-Fix-use-of-half-initialized-result-in-getaddrinfo-wh.patch
ApplyPatch 0001-Make-x86_64-fegetenv-preserve-exception-mask-bug-161.patch
ApplyPatch 0001-Fix-nscd-lookup-for-innetgr-when-netgroup-has-wildca.patch
ApplyPatch 0001-Fix-clog10-0-0i-bug-16362.patch
ApplyPatch 0001-Correct-robust-mutex-PI-futex-kernel-assumptions-bug.patch
ApplyPatch 0001-BZ-16824-Fix-failing-y1-due-to-too-large-ulps-in-dow.patch
ApplyPatch 0001-Fix-invalid-file-descriptor-reuse-while-sending-DNS-.patch
ApplyPatch 0001-Fix-__ieee754_logl-LDBL_MAX-in-FE_DOWNWARD-mode-bug-.patch
ApplyPatch 0001-Don-t-ignore-too-long-lines-in-nss_files-BZ-17079.patch
ApplyPatch 0001-Fix-fallback-fesetenv-and-feupdateenv-on-FE_NOMASK_E.patch

set +e +o pipefail
