
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

PATCHCOM="patch -p1 -s --verbose"

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
#zcat ${CWD}/glibc.locale.no-archive.diff.gz | patch -p1 --verbose
# The is_IS locale is causing a strange error about the "echn" command
# not existing.  This patch reverts is_IS to the version shipped in
# glibc-2.5:
#zcat ${SB_PATCHDIR}/is_IS.diff.gz | patch -p1 --verbose
# Fix NIS netgroups:
zcat ${SB_PATCHDIR}/glibc.nis-netgroups.diff.gz | patch -p1 --verbose
# Evidently glibc never expected Linux kernel versions to be in the
# format 1.2.3.4.  This patch makes glibc consider the kernel version
# to be only the first three digit groups found, and drops any
# trailing non-digit characters:
#zcat ${SB_PATCHDIR}/glibc.kernelversion.diff.gz | patch -p1 --verbose
# Support ru_RU.CP1251 locale:
#zcat ${CWD}/glibc.ru_RU.CP1251.diff.gz | patch -p1 --verbose
# Fix missing MAX macro in getcwd.c:
zcat ${SB_PATCHDIR}/glibc.getcwd.max.macro.diff.gz | patch -p1 --verbose
# Gentoo patches
( SB_PATCHDIR=patches

  ApplyPatch 0030_all_glibc-respect-env-CPPFLAGS.patch
  ApplyPatch 0044_all_glibc-2.10-resolv-nameserver-fallback.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/0070_all_glibc-i386-x86_64-revert-clone-cfi.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/0085_all_glibc-disable-ldconfig.patch
  ApplyPatch 1010_all_glibc-queue-header-updates.patch
  ApplyPatch 1020_all_glibc-longjmp-chk-hidden-fortify.patch
  ApplyPatch 1030_all_glibc-manual-no-perl.patch
  ApplyPatch 1040_all_2.3.3-localedef-fix-trampoline.patch
  ApplyPatch 1055_all_glibc-resolv-dynamic.patch
  ApplyPatch 1060_all_glibc-localedef-mmap.patch
  ApplyPatch 1070_all_glibc-fadvise64_64.patch
  #ApplyPatch 1073_all_glibc-ldbl-nexttowardf.patch
  ApplyPatch 1075_all_glibc-section-comments.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1080_all_glibc-no-inline-gmon.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1085_all_glibc-2.9-check_native-headers.patch
  ApplyPatch 1090_all_glibc-2.3.6-fix-pr631.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1095_all_glibc-2.9-assume-pipe2.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1100_all_glibc-2.3.3-china.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1103_all_glibc-new-valencian-locale.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1130_all_glibc-2.4-undefine-__i686.patch
  ApplyPatch 1160_all_glibc-2.8-nscd-one-fork.patch
  ApplyPatch 3020_all_glibc-tests-sandbox-libdl-paths.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/5021_all_2.9-fnmatch.patch
  ApplyPatch 5063_all_glibc-dont-build-timezone.patch

) || exit 1

# Mandriva
ApplyPatch glibc-2.11.1-localedef-archive-follow-symlinks.patch 
ApplyPatch glibc-2.9-ldd-non-exec.patch.gz
ApplyPatch glibc-2.2-nss-upgrade.patch.gz
ApplyPatch glibc-2.4.90-compat-EUR-currencies.patch.gz
ApplyPatch glibc-2.9-nscd-no-host-cache.patch.gz
ApplyPatch glibc-2.3.2-tcsetattr-kernel-bug-workaround.patch.gz
ApplyPatch glibc-2.10.1-biarch-cpp-defines.patch.gz
ApplyPatch glibc-2.6-nice_fix.patch.gz
ApplyPatch glibc-2.8-ENOTTY-fr-translation.patch.gz
ApplyPatch glibc-2.4.90-gcc4-fortify.patch.gz
ApplyPatch glibc-2.3.5-biarch-utils.patch.gz
ApplyPatch glibc-2.10.1-multiarch.patch.gz
ApplyPatch glibc-2.3.6-pt_BR-i18nfixes.patch.gz
ApplyPatch glibc-2.11-Follow-kernel-F_OWNER_-GID-PGRP-change.patch
ApplyPatch glibc-2.11-Try-harder-to-re-exec-nscd-in-paranoia-mode.patch
ApplyPatch glibc-2.11-Use-struct-timespec-for-timestamps-in-struct-stat-al.patch
ApplyPatch glibc-2.11-Define-SCHED_IDLE-and-SCHED_RESET_ON_FORK-for-Linux.patch
ApplyPatch glibc-2.11-Redefine-O_SYNC-and-O_DSYNC-to-match-2.6.33-kernels.patch
ApplyPatch glibc-2.11-Invalid-timeouts-in-i386-sem_timedwait.patch.gz
ApplyPatch glibc-2.11-Avoid-ELF-lookup-race.patch
ApplyPatch glibc-2.11-Update-poll.h-header-for-POSIX-2008.patch
ApplyPatch glibc-2.11-check-fd-arg-in-futimens.patch
ApplyPatch glibc-2.11-Additional-setcontext-etc.-conformance-tests.patch
ApplyPatch glibc-2.11-Fix-typo-in-feature-selection-macro-use.patch
ApplyPatch glibc-2.11-Add-nonnull-attribute-to-unsetenv-declaration.patch
ApplyPatch glibc-2.11-Prevent-silent-errors-should-x86-64-strncmp-be-neede.patch
ApplyPatch glibc-2.11-Fix-malloc_info-without-prioor-allocations.patch
ApplyPatch glibc-2.11-Pass-sysdep-LDFLAGS-when-using-print-file-name.patch
ApplyPatch glibc-2.11-Make-unistd.h-pre-c-safe.patch
ApplyPatch glibc-2.11-regcomp.c-do-not-ignore-memory-allocation-failure.patch
ApplyPatch glibc-2.11-Always-use-IPv4-sockets-for-IPv4-addresses.patch
ApplyPatch glibc-2.11-Define-IPTOS_CLASS_-macros-according-to-RFC-2474.patch
ApplyPatch glibc-2.11-Fix-a-few-more-cases-of-ignored-return-values-in-reg.patch
ApplyPatch glibc-2.11-sysdeps-ieee754-ldbl-128-fixes.patch
ApplyPatch glibc-2.11-Ignore-negative-dynamic-entry-types.patch
ApplyPatch glibc-2.11-Use-correct-type-when-casting-d_tag.patch
ApplyPatch glibc-2.11-Remove-duplicate-definitions-of-O_DSYNC-and-O_RSYNC.patch
ApplyPatch glibc-2.11-Remove-unnecessary-returns.patch
ApplyPatch glibc-2.11-more-re-fixes.patch
ApplyPatch glibc-2.11-_nl_load_locale-incorrectly-handles-mmap-failures.patch
ApplyPatch glibc-2.11-Fix-error-checking-in-iconv.patch
ApplyPatch glibc-2.11-Don-t-map-U00DF-to-U1E9E-in-toupper-table.patch
ApplyPatch glibc-2.11-Avoid-alloca-in-setenv-for-long-strings.patch
ApplyPatch glibc-2.11-Fix-sorting-of-malayalam-letter-na.patch
ApplyPatch glibc-2.11-Fix-endless-loop-with-invalid-etc-shells-file.patch
ApplyPatch glibc-2.11-Update-constants-for-current-kernels.patch
ApplyPatch glibc-2.11-Fix-file-descriotor-leak-in-nftw-with-FTW_CHDIR.patch

set +e +o pipefail
