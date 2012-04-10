
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

PATCHCOM="patch -p1 -s --backup --verbose"

ApplyPatch() {
  local patch=$1
  shift
  if [ ! -f ${SB_PATCHDIR}/${patch} ]; then
    exit 1
  fi
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
# This fixes a security issue in glibc 2.12.1 and earlier:
ApplyPatch glibc.CVE-2010-3847.diff
# fedora "fix" for excess linker optimization on i686
ApplyPatch glibc-2.12.1-but-I-am-an-i686.patch
# http://sources.redhat.com/bugzilla/show_bug.cgi?id=411
# http://sourceware.org/ml/libc-alpha/2009-07/msg00072.html
ApplyPatch glibc-__i686.patch
# http://www.exploit-db.com/exploits/15274/
# http://sourceware.org/git/?p=glibc.git;a=patch;h=d14e6b09 (only fedora branch...)
ApplyPatch glibc-2.12.2-ignore-origin-of-privileged-program.patch

if [ "${SB_BOOTSTRP}" = "YES" ] ;then
  # Multilib - Disable check for forced unwind (Patch from eglibc) since we
  # do not have a multilib glibc yet to link to;
  ApplyPatch glibc.pthread-disable-forced-unwind-check.diff
fi

# Gentoo patches
patch -p0 --verbose -i ${SB_PATCHDIR}/0070_all_glibc-i386-x86_64-revert-clone-cfi.patch
( SB_PATCHDIR=patches

  ApplyPatch 0020_all_glibc-tweak-rfc1918-lookup.patch
  ApplyPatch 0050_all_glibc-2.14-leak-revert-crash.patch
  ApplyPatch 0052_all_glibc-2.14-resolv-hp-assert.patch
  ApplyPatch 0061_all_glibc-2.13-static-memset.patch
  ApplyPatch 0068_all_glibc-2.14-glibc-revert-fseek-on-fclose.patch
  ApplyPatch 0070_all_glibc-2.14-rpc-export.patch
  ApplyPatch 0080_all_glibc-2.15-revert-x86_64-eagain-pthread_cond_wait.patch
  ApplyPatch 0081_all_glibc-2.15-math64crash.patch
  ApplyPatch 0082_all_glibc-2.16-scanf.patch
  ApplyPatch 0085_all_glibc-disable-ldconfig.patch
  ApplyPatch 1005_all_glibc-sigaction.patch
  ApplyPatch 1010_all_glibc-queue-header-updates.patch
  ApplyPatch 1030_all_glibc-manual-no-perl.patch
  ApplyPatch 1040_all_2.3.3-localedef-fix-trampoline.patch
  ApplyPatch 1055_all_glibc-resolv-dynamic.patch
  ApplyPatch 1070_all_glibc-fadvise64_64.patch
  ApplyPatch 1075_all_glibc-section-comments.patch
  ApplyPatch 1080_all_glibc-no-inline-gmon.patch
  ApplyPatch 1090_all_glibc-2.3.6-fix-pr631.patch
  ApplyPatch 1095_all_glibc-2.14-assume-pipe2-dup3.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1103_all_glibc-new-valencian-locale.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1120_all_glibc-2.11-longjmp-chk-fallback.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1130_all_glibc-2.4-undefine-__i686.patch
  ApplyPatch 1160_all_glibc-2.8-nscd-one-fork.patch
  ApplyPatch 3020_all_glibc-tests-sandbox-libdl-paths.patch
  ApplyPatch 5063_all_glibc-dont-build-timezone.patch

)

# Arch
ApplyPatch glibc-2.15-lddebug-scopes.patch
ApplyPatch glibc-2.15-revert-netlink-cache.patch
ApplyPatch glibc-2.15-negative-result-cache.patch
ApplyPatch glibc-2.15-multiarch-x86-strcmp.patch
ApplyPatch glibc-2.15-vdso.patch
ApplyPatch glibc-2.15-feraiseexcept-plt.patch
ApplyPatch glibc-2.15-vfprintf-nargs.patch
ApplyPatch glibc-2.15-__libc_res_nquerydomain-out-of-bounds.patch
ApplyPatch glibc-2.15-fmtmsg-locking.patch
ApplyPatch glibc-2.15-non-signalling-comparisons.patch
ApplyPatch glibc-2.15-rintf-rounding.patch
ApplyPatch glibc-2.15-nearbyintf-rounding.patch
ApplyPatch glibc-2.15-confstr-local-buffer-extent.patch

# Mandriva
ApplyPatch glibc-2.11.1-localedef-archive-follow-symlinks.patch 
ApplyPatch glibc-2.9-ldd-non-exec.patch.gz
ApplyPatch glibc-2.15-nss-upgrade.patch
ApplyPatch glibc-2.4.90-compat-EUR-currencies.patch.gz
ApplyPatch glibc-2.9-nscd-no-host-cache.patch.gz
ApplyPatch glibc-2.3.2-tcsetattr-kernel-bug-workaround.patch.gz
ApplyPatch glibc-2.10.1-biarch-cpp-defines.patch.gz
ApplyPatch glibc-2.6-nice_fix.patch.gz
ApplyPatch glibc-2.8-ENOTTY-fr-translation.patch.gz
ApplyPatch glibc-2.4.90-gcc4-fortify.patch.gz
ApplyPatch glibc-2.3.5-biarch-utils.patch.gz
ApplyPatch glibc-2.15-multiarch.patch
ApplyPatch glibc-2.3.6-pt_BR-i18nfixes.patch.gz

# master

set +e +o pipefail
