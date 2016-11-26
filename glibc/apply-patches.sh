
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
ApplyPatch glibc.locale.no-archive.diff
# The is_IS locale is causing a strange error about the "echn" command
# not existing.  This patch reverts is_IS to the version shipped in
# glibc-2.5:
ApplyPatch is_IS.diff.gz
# Fix NIS netgroups:
ApplyPatch glibc.nis-netgroups.diff
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

  ApplyPatch 00_all_0001-x86-Use-sysdep.o-from-libc.a-in-static-libraries.patch
  ApplyPatch 00_all_0002-malloc-Preserve-arena-free-list-thread-count-invaria.patch
  ApplyPatch 00_all_0003-Update-from-Translation-Project.patch
  ApplyPatch 00_all_0004-powerpc-fix-ifunc-sel.h-with-GCC-6.patch
  ApplyPatch 00_all_0005-powerpc-fix-ifunc-sel.h-fix-asm-constraints-and-clob.patch
  ApplyPatch 00_all_0006-Fix-sNaN-handling-in-nearbyint-on-32-bit-sparc.patch
  ApplyPatch 00_all_0007-sparc-remove-fdim-sparc-specific-implementations.patch
  ApplyPatch 00_all_0008-Do-not-override-objects-in-libc.a-in-other-static-li.patch
  ApplyPatch 00_all_0009-arm-mark-__startcontext-as-.cantunwind-bug-20435.patch
  ApplyPatch 00_all_0010-argp-Do-not-override-GCC-keywords-with-macros-BZ-169.patch
  ApplyPatch 00_all_0011-nptl-tst-once5-Reduce-time-to-expected-failure.patch
  ApplyPatch 00_all_0012-NaCl-Fix-compile-error-in-clock-function.patch
  ApplyPatch 00_all_0013-Fix-generic-wait3-after-union-wait_status-removal.patch
  ApplyPatch 00_all_0014-NaCl-Fix-compile-error-for-__dup-after-libc_hidden_p.patch
  ApplyPatch 00_all_0015-NaCl-Fix-libc.abilist-missing-GLIBC_2.24-A.patch
  ApplyPatch 00_all_0016-powerpc-Fix-POWER9-implies.patch
  ApplyPatch 00_all_0017-posix-Correctly-enable-disable-cancellation-on-Linux.patch
  ApplyPatch 00_all_0018-posix-Correctly-block-unblock-all-signals-on-Linux-p.patch
  ApplyPatch 00_all_0019-powerpc-Regenerate-ULPs.patch
  ApplyPatch 00_all_0020-Fix-Linux-sh4-pread-pwrite-argument-passing.patch
  ApplyPatch 00_all_0021-Fix-cmpli-usage-in-power6-memset.patch
  ApplyPatch 00_all_0022-gconv.h-fix-build-with-GCC-7.patch
  ApplyPatch 00_all_0023-Fix-linknamespace-parallel-test-failures.patch
  ApplyPatch 00_all_0024-disable-ldconfig-during-install.patch
  ApplyPatch 00_all_0025-reload-etc-resolv.conf-when-it-has-changed.patch
  ApplyPatch 00_all_0026-rtld-do-not-ignore-arch-specific-CFLAGS.patch
  ApplyPatch 00_all_0027-gentoo-support-running-tests-under-sandbox.patch
  ApplyPatch 00_all_0028-sys-types.h-drop-sys-sysmacros.h-include.patch
  ApplyPatch 00_all_0029-configure-accept-__stack_chk_fail_local-for-ssp-supp.patch
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

# Fix -Warray-bounds warning for GCC5, likely PR/59124 or PR/66422.
ApplyPatch glibc-res-hconf-gcc5.patch
ApplyPatch glibc-ld-ctype-gcc5.patch
ApplyPatch glibc-gethnamaddr-gcc5.patch
ApplyPatch glibc-dns-host-gcc5.patch
ApplyPatch glibc-bug-regex-gcc5.patch

# Add C.UTF-8 locale into /usr/lib/locale/
ApplyPatch glibc-c-utf8-locale.patch

# http://sourceware.org/ml/libc-alpha/2012-12/msg00103.html
ApplyPatch glibc-rh697421.patch
ApplyPatch glibc-rh741105.patch
# Upstream BZ 14247
ApplyPatch glibc-rh827510.patch
# Upstream BZ 14185
ApplyPatch glibc-rh819430.patch
# Fix nscd to use permission names not constants.
ApplyPatch glibc-rh1070416.patch
ApplyPatch glibc-aarch64-tls-fixes.patch
ApplyPatch glibc-aarch64-workaround-nzcv-clobber-in-tlsdesc.patch

ApplyPatch glibc-gcc-PR69537.patch

# extend_alloca removal, BZ 18023
ApplyPatch glibc-rh1315108.patch
ApplyPatch glibc-rh1335011.patch

# Upstream BZ 20313
ApplyPatch glibc-rh1351108-update-to-unicode-9.0.0.patch

# sln implemented by ldconfig, to conserve disk space.
ApplyPatch glibc-rh1315476-1.patch

## Mandriva
ApplyPatch glibc-2.11.1-localedef-archive-follow-symlinks.patch 
ApplyPatch glibc-2.9-ldd-non-exec.patch.gz
ApplyPatch glibc-2.17-nss-upgrade.patch
ApplyPatch glibc-2.19-compat-EUR-currencies.patch
ApplyPatch glibc-2.9-nscd-no-host-cache.patch.gz
ApplyPatch glibc-2.10.1-biarch-cpp-defines.patch.gz
ApplyPatch glibc-2.22-nice_fix.patch
ApplyPatch glibc-2.3.5-biarch-utils.patch.gz
ApplyPatch glibc-2.24-multiarch.patch
ApplyPatch glibc-2.22-pt_BR-i18nfixes.patch

### Arch


### master


set +e +o pipefail
