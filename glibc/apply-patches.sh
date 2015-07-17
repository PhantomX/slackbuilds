
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
  ApplyPatch 00_all_0008-gentoo-support-running-tests-under-sandbox.patch
  ApplyPatch 00_all_0009-gentoo-disable-building-in-timezone-subdir.patch
  ApplyPatch 00_all_0016-Fix-__memcpy_chk-on-non-SSE2-CPUs.patch
)

## Fedora
# Needs to be sent upstream
ApplyPatch glibc-fedora-include-bits-ldbl.patch

ApplyPatch glibc-fedora-linux-tcsetattr.patch
ApplyPatch glibc-fedora-nptl-linklibc.patch
ApplyPatch glibc-fedora-i386-tls-direct-seg-refs.patch
ApplyPatch glibc-fedora-nis-rh188246.patch
ApplyPatch glibc-fedora-locarchive.patch
ApplyPatch glibc-fedora-streams-rh436349.patch
ApplyPatch glibc-fedora-localedata-rh61908.patch
ApplyPatch glibc-fedora-uname-getrlimit.patch
ApplyPatch glibc-fedora-__libc_multiple_libcs.patch
ApplyPatch glibc-fedora-elf-ORIGIN.patch
ApplyPatch glibc-fedora-elf-init-hidden_undef.patch

# Support mangling and demangling null pointers.
ApplyPatch glibc-rh952799.patch

# Allow applications to call pthread_atfork without libpthread.so.
ApplyPatch glibc-rh1013801.patch

ApplyPatch glibc-nscd-sysconfig.patch
sed -i -e 's|/sysconfig/|/default/|g' nscd/nscd.service

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
ApplyPatch glibc-rh1070416.patch
ApplyPatch glibc-aarch64-tls-fixes.patch
ApplyPatch glibc-aarch64-workaround-nzcv-clobber-in-tlsdesc.patch

## Mandriva
ApplyPatch glibc-2.11.1-localedef-archive-follow-symlinks.patch 
ApplyPatch glibc-2.9-ldd-non-exec.patch.gz
ApplyPatch glibc-2.17-nss-upgrade.patch
ApplyPatch glibc-2.19-compat-EUR-currencies.patch
ApplyPatch glibc-2.9-nscd-no-host-cache.patch.gz
ApplyPatch glibc-2.10.1-biarch-cpp-defines.patch.gz
ApplyPatch glibc-2.6-nice_fix.patch
ApplyPatch glibc-2.3.5-biarch-utils.patch.gz
ApplyPatch glibc-2.16-multiarch.patch
ApplyPatch glibc-2.21-pt_BR-i18nfixes.patch

### Arch

### master
ApplyPatch 0001-x86-Clean-up-__vdso_clock_gettime-variable.patch
ApplyPatch 0001-Fix-sincos-errno-setting-bug-15467.patch
ApplyPatch 0001-Fix-dbl-64-wordsize-64-remquo-bug-17569.patch
ApplyPatch 0001-Filter-out-PTHREAD_MUTEX_NO_ELISION_NP-bit-in-pthrea.patch
ApplyPatch 0001-Fix-exp2-spurious-underflows-bug-16560.patch
ApplyPatch 0001-Fix-remquo-spurious-overflows-bug-17978.patch
ApplyPatch 0001-Fix-sign-of-remquo-zero-remainder-in-round-downward-.patch
ApplyPatch 0001-Fix-posix_spawn-getrlimit64-namespace-bug-17991.patch
ApplyPatch 0001-Fix-search.h-namespace-bug-17996.patch
ApplyPatch 0001-Fix-atan-atan2-missing-underflows-bug-15319.patch
ApplyPatch 0002-Fix-scandir-scandirat-namespace-bug-17999.patch
ApplyPatch 0001-Adjust-timeouts-for-some-tests-to-accommodate-slow-p.patch
ApplyPatch 0001-Compile-gcrt1.o-with-fPIC.patch
ApplyPatch 0001-linux-open-and-openat-ignore-mode-with-O_TMPFILE-in-.patch
ApplyPatch 0001-Fix-x86-x86_64-scalb-qNaN-Inf-bug-16783.patch
ApplyPatch 0002-alloca-fix-buf-interaction.patch
ApplyPatch 0003-Fix-ldbl-128ibm-acoshl-inaccuracy-bug-18019.patch
ApplyPatch 0001-BZ-15969-search-locale-archive-again-after-alias-exp.patch
ApplyPatch 0002-Fix-constness-error-just-introduced-in-findlocale.patch
ApplyPatch 0001-Fix-asin-missing-underflows-bug-16351.patch
ApplyPatch 0001-Fix-BZ-18043-buffer-overflow-read-past-the-end-in-wo.patch
ApplyPatch 0001-Refactor-wordexp-test.c-such-that-words-always-ends-.patch
ApplyPatch 0002-Fix-off-by-one-which-caused-BZ-18042-and-add-a-test-.patch
ApplyPatch 0001-Fix-BZ-18043-c4-buffer-overflow-read-past-the-end-in.patch
ApplyPatch 0001-powerpc-Remove-HAVE_ASM_GLOBAL_DOT_NAME-define.patch
ApplyPatch 0001-Avoid-SIGFPE-in-wordexp-BZ-18100.patch
ApplyPatch 0001-Fix-DTV-race-assert-DTV_SURPLUS-Static-TLS-limit-and.patch
ApplyPatch 0001-Fuller-check-for-invalid-NSID-in-_dl_open.patch
ApplyPatch 0002-Avoid-confusing-compiler-with-dynamically-impossible.patch
ApplyPatch 0003-Better-fix-for-setenv-.-NULL.patch
ApplyPatch 0001-CVE-2015-1781-resolv-nss_dns-dns-host.c-buffer-overf.patch
ApplyPatch 0001-Make-time-zone-file-parser-more-robust-BZ-17715.patch
ApplyPatch 0001-Record-TTL-also-for-DNS-PTR-queries-bug-18513.patch
ApplyPatch 0001-Update-headers-for-Linux-4.0-4.1-definitions.patch
ApplyPatch 0001-Set-errno-to-ENOMEM-on-overflow-in-sbrk-bug-18592.patch
ApplyPatch 0001-Fix-ruserok-scalability-with-large-.rhosts-file.patch

set +e +o pipefail
