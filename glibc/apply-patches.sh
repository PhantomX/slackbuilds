
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
zcat ${SB_PATCHDIR}/glibc.locale.no-archive.diff.gz | patch -p1 --verbose
# The is_IS locale is causing a strange error about the "echn" command
# not existing.  This patch reverts is_IS to the version shipped in
# glibc-2.5:
zcat ${SB_PATCHDIR}/is_IS.diff.gz | patch -p1 --verbose
# Fix NIS netgroups:
zcat ${SB_PATCHDIR}/glibc.nis-netgroups.diff.gz | patch -p1 --verbose
# Support ru_RU.CP1251 locale:
zcat ${SB_PATCHDIR}/glibc.ru_RU.CP1251.diff.gz | patch -p1 --verbose
# Fix missing MAX macro in getcwd.c:
zcat ${SB_PATCHDIR}/glibc.getcwd.max.macro.diff.gz | patch -p1 --verbose
# Avoid the Intel optimized asm routines for now because they break
# the flash player.  We'll phase this in when it's safer to do so.
ApplyPatch glibc.disable.broken.optimized.memcpy.diff
# fedora "fix" for excess linker optimization on i686
ApplyPatch glibc-2.12.1-but-I-am-an-i686.patch
# http://sources.redhat.com/bugzilla/show_bug.cgi?id=411
# http://sourceware.org/ml/libc-alpha/2009-07/msg00072.html
ApplyPatch glibc-__i686.patch

if [ "${SB_BOOTSTRP}" = "YES" ] ;then
  # Multilib - Disable check for forced unwind (Patch from eglibc) since we
  # do not have a multilib glibc yet to link to;
  ApplyPatch glibc.pthread-disable-forced-unwind-check.diff
fi

# Gentoo patches
( SB_PATCHDIR=patches

  ApplyPatch 0035_all_glibc-2.16-i386-math-feraiseexcept-overhead.patch
  ApplyPatch 0085_all_glibc-disable-ldconfig.patch
  ApplyPatch 1005_all_glibc-sigaction.patch
  ApplyPatch 1008_all_glibc-2.16-fortify.patch
  ApplyPatch 1040_all_2.3.3-localedef-fix-trampoline.patch
  ApplyPatch 1055_all_glibc-resolv-dynamic.patch
  ApplyPatch 3020_all_glibc-tests-sandbox-libdl-paths.patch
  ApplyPatch 5063_all_glibc-dont-build-timezone.patch

)

# Mandriva
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

# master
ApplyPatch 0001-BZ-14317-Optimze-__xpg_strerror_r.patch
ApplyPatch 0002-Add-values-from-Linux-3.7-to-elf.h.patch
ApplyPatch 0001-Fix-casinh-casin-inaccuracy-from-cancellation-bug-14.patch
ApplyPatch 0001-Fix-localedef-posix-description.patch
ApplyPatch 0001-Fix-casinh-casin-overflow-bug-14996.patch
ApplyPatch 0001-BZ-14985-Remove-erroneous-EPOLL_NONBLOCK.patch
ApplyPatch 0001-Implement-x86-SIZE32-SIZE64-relocations.patch
ApplyPatch 0001-Fix-cacos-real-part-inaccuracy-for-result-real-part-.patch
ApplyPatch 0001-Make-bits-wchar.h-correct-for-all-architectures-bug-.patch
ApplyPatch 0001-Fix-casinh-spurious-underflows-away-from-i-i-bug-150.patch
ApplyPatch 0001-Fix-aliases-in-stub-lseek.patch
ApplyPatch 0001-BZ-15055-Use-__ieee754_sqrl-in-acoshl-for-lbdl-128ib.patch
ApplyPatch 0001-Fix-y1l-spurious-overflows-for-ldbl-96-bug-15283.patch
ApplyPatch 0001-Fix-types-of-constants-in-k_casinh-.c.patch
ApplyPatch 0001-Fix-casinh-inaccuracy-for-argument-with-imaginary-pa.patch
ApplyPatch 0001-BZ-14812-Add-missing-translation-marker-on-some-argp.patch
ApplyPatch 0001-BZ-14812-Add-missing-N_-markers-in-localedef.patch
ApplyPatch 0001-BZ-11120-fix-x86_64-strcmp.S-NOT_IN_libc-safeguards.patch
ApplyPatch 0002-BZ-13889-expl-709.75-wrongly-overflows-for-ldbl-128i.patch
ApplyPatch 0001-Don-t-add-input-group-during-initgroups_dyn-in-hesio.patch
ApplyPatch 0002-Fix-e_logl-128ibm-spurious-underflow.patch
ApplyPatch 0001-Fix-casinh-inaccuracy-near-i-imaginary-part-1-bug-15.patch
ApplyPatch 0001-Fix-casinh-inaccuracy-for-imaginary-part-1.0-real-pa.patch
ApplyPatch 0001-Fix-cacosh-inaccuracy-and-spurious-exceptions-bug-15.patch
ApplyPatch 0001-Fix-missing-underflow-from-cexp-bug-14478.patch
ApplyPatch 0001-BZ-15086-Fix-res_debug-printing-of-options.patch
ApplyPatch 0002-BZ-15380-Fix-initstate-error-return.patch
ApplyPatch 0003-BZ-15085-Fix-comments-strings-for-RES_NOCHECKNAME.patch
ApplyPatch 0004-BZ-15084-Apparent-typos-in-strings-in-res_debug.c.patch
ApplyPatch 0001-Use-stat64-instead-of-stat-in-installed-programs.patch

# From Arch
# combination of upstream commits 318cd0b, b540704 and fc1abbe
ApplyPatch glibc-2.17-sync-with-linux37.patch
# CVE-2013-1914 - upstream commit 1cef1b19
ApplyPatch glibc-2.17-getaddrinfo-stack-overflow.patch
# CVE-2013-0242 - upstream commit a445af0b
ApplyPatch glibc-2.17-regexp-matcher-overrun.patch

ApplyPatch 0001-Sync-with-Linux-3.9.patch

set +e +o pipefail
