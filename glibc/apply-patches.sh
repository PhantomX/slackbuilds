
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

unset PATCH_VERBOSE_OPT
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch -p1 -s --backup ${PATCH_VERBOSE_OPT}"

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
  ApplyPatch 00_all_0009-gentoo-support-running-tests-under-sandbox.patch
  ApplyPatch 00_all_0010-gentoo-disable-building-in-timezone-subdir.patch
  ApplyPatch 00_all_0015-Accept-make-versions-4.0-and-greater.patch
  ApplyPatch 00_all_0016-Don-t-use-broken-DL_AUTO_FUNCTION_ADDRESS.patch
  ApplyPatch 00_all_0017-ptrace.h-add-__-prefix-to-ptrace_peeksiginfo_args.patch
  ApplyPatch 00_all_0018-ia64-add-__-prefix-to-pt_all_user_regs-ia64_fpreg-BZ.patch
  ApplyPatch 00_all_0019-ARM-Fix-clone-code-when-built-for-Thumb.patch
  ApplyPatch 00_all_0020-Fix-PI-mutex-check-in-pthread_cond_broadcast-and-pth.patch
  ApplyPatch 00_all_0021-CVE-2013-4237-BZ-14699-Buffer-overflow-in-readdir_r.patch
  ApplyPatch 00_all_0022-elf-setup-vdso.h-setup_vdso-Fix-missing-string-termi.patch
  ApplyPatch 00_all_0023-PowerPC-fix-POWER7-memrchr-for-some-large-inputs.patch
  ApplyPatch 00_all_0024-Fix-memory-leaks-in-libio-on-allocation-failure.patch
  ApplyPatch 00_all_0025-Fix-memory-leak-in-stdlib-isomac.c.patch
  ApplyPatch 00_all_0026-Fix-stack-overflow-due-to-large-AF_INET6-requests.patch
  ApplyPatch 00_all_0028-malloc-Check-for-integer-overflow-in-pvalloc.patch
  ApplyPatch 00_all_0029-malloc-Check-for-integer-overflow-in-valloc.patch
  ApplyPatch 00_all_0030-malloc-Check-for-integer-overflow-in-memalign.patch
  ApplyPatch 00_all_0032-Fix-build-on-pre-v9-32-bit-Sparc.patch
  ApplyPatch 00_all_0033-Fix-sparc-64-bit-GMP-ifunc-resolution-in-static-buil.patch
)

## Fedora
ApplyPatch glibc-fedora-nptl-linklibc.patch
ApplyPatch glibc-fedora-i386-tls-direct-seg-refs.patch
ApplyPatch glibc-fedora-gai-canonical.patch
ApplyPatch glibc-fedora-pt_chown.patch
ApplyPatch glibc-fedora-elf-rh737223.patch
ApplyPatch glibc-fedora-elf-ORIGIN.patch
ApplyPatch glibc-fedora-elf-init-hidden_undef.patch

ApplyPatch glibc-rh911307.patch
ApplyPatch glibc-rh952799.patch

ApplyPatch glibc-rh757881.patch
# Upstream BZ 9954
ApplyPatch glibc-rh739743.patch
# Upstream BZ 13818
ApplyPatch glibc-rh800224.patch
# Upstream BZ 14247
ApplyPatch glibc-rh827510.patch
# Upstream BZ 13028
ApplyPatch glibc-rh841787.patch
# Upstream BZ 14185
ApplyPatch glibc-rh819430.patch
#Upstream BZ 14547
ApplyPatch glibc-strcoll-cve.patch
# Initialize res_hconf in nscd
ApplyPatch glibc-rh1000924.patch
# Upstream BZ 15754
ApplyPatch glibc-rh985625-CVE-2013-4788.patch

## Mandriva
ApplyPatch glibc-2.11.1-localedef-archive-follow-symlinks.patch 
ApplyPatch glibc-2.9-ldd-non-exec.patch.gz
ApplyPatch glibc-2.15-nss-upgrade.patch
ApplyPatch glibc-2.4.90-compat-EUR-currencies.patch.gz
ApplyPatch glibc-2.9-nscd-no-host-cache.patch.gz
ApplyPatch glibc-2.3.2-tcsetattr-kernel-bug-workaround.patch.gz
ApplyPatch glibc-2.10.1-biarch-cpp-defines.patch.gz
ApplyPatch glibc-2.6-nice_fix.patch
ApplyPatch glibc-2.8-ENOTTY-fr-translation.patch.gz
ApplyPatch glibc-2.3.5-biarch-utils.patch.gz
ApplyPatch glibc-2.16-multiarch.patch
ApplyPatch glibc-2.3.6-pt_BR-i18nfixes.patch.gz

## master
ApplyPatch 0001-Fix-cbrtl-for-ldbl-96.patch
ApplyPatch 0001-BZ-15897-dlfcn-do-not-mark-dlopen-dlclose-as-leaf-fu.patch
ApplyPatch 0001-BZ-15522-strtod-nan-N-returning-a-sNaN-in-some-cases.patch
ApplyPatch 0001-Fix-spurious-jnf-underflows-bug-14155.patch
ApplyPatch 0001-Fix-lgammaf-spurious-underflow-bug-15427.patch
ApplyPatch 0001-Add-O_TMPFILE-to-fcntl.h.patch
ApplyPatch 0001-Fix-buffer-overrun-in-strtod_l.patch
ApplyPatch 0001-BZ-15859-Fix-memory-leak-in-_dl_map_object_deps.patch
ApplyPatch 0001-Clear-initfini-list-after-freeing.-Fixes-bug-15308.patch
ApplyPatch 0001-Fix-inet_network-1-bar-.-Fixes-bug-15277.patch
ApplyPatch 0002-Remove-assert-in-malloc-statistic.-Fixes-bug-12486.patch
ApplyPatch 0001-Replace-alloca-in-__tzfile_read-by-malloc.-Fixes-bug.patch
ApplyPatch 0002-When-glob-pattern-contains-a-trailing-slash-match-on.patch
ApplyPatch 0001-Make-strptime-Z-consistent-between-doc-and-code.-Fix.patch
ApplyPatch 0001-Use-atomic-operations-to-track-memory.-Fixes-bug-110.patch
ApplyPatch 0001-Restrict-shm_open-and-shm_unlink-to-SHMDIR.-Fixes-bu.patch
ApplyPatch 0001-Fix-malloc_info-statistic.-Fixes-bug-16112.patch
ApplyPatch 0001-Make-getent-services-compliant-with-RFC-6335-section.patch
ApplyPatch 0001-Fix-strtod-rounding-of-half-the-least-subnormal-bug-.patch
ApplyPatch 0001-Do-not-let-scanf-4p-accept-nil-.-Fixes-bug-16055.patch
ApplyPatch 0001-Get-canonical-name-in-getaddrinfo-from-hosts-file-fo.patch
ApplyPatch 0001-Return-fixed-version-of-breaking-of-RPATH-when-ORIGI.patch
ApplyPatch 0001-Properly-handle-shm_open-validation.-Fixes-bug-16274.patch
ApplyPatch 0001-BZ-15941-Fix-INSTALL-file-regeneration-failure-with-.patch

## From Arch
ApplyPatch glibc-2.18-strstr-hackfix.patch
# upstream commit a4966c61
ApplyPatch glibc-2.18-scanf-parse-0e-0.patch

set +e +o pipefail
