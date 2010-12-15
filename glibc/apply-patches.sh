
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

if [ "${SB_BOOTSTRP}" = "YES" ] ;then
  # Multilib - Disable check for forced unwind (Patch from eglibc) since we
  # do not have a multilib glibc yet to link to;
  ApplyPatch glibc.pthread-disable-forced-unwind-check.diff
fi

# Gentoo patches
#patch -p0 --verbose -i ${SB_PATCHDIR}/0070_all_glibc-i386-x86_64-revert-clone-cfi.patch
( SB_PATCHDIR=patches

  ApplyPatch 0020_all_glibc-tweak-rfc1918-lookup.patch
  ApplyPatch 0030_all_glibc-respect-env-CPPFLAGS.patch
  ApplyPatch 0044_all_glibc-2.10-resolv-nameserver-fallback.patch
  ApplyPatch 0055_all_glibc-2.12-static-shared-getpagesize.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/0085_all_glibc-disable-ldconfig.patch
  ApplyPatch 1010_all_glibc-queue-header-updates.patch
  ApplyPatch 1020_all_glibc-longjmp-chk-hidden-fortify.patch
  ApplyPatch 1030_all_glibc-manual-no-perl.patch
  ApplyPatch 1040_all_2.3.3-localedef-fix-trampoline.patch
  ApplyPatch 1055_all_glibc-resolv-dynamic.patch
  ApplyPatch 1060_all_glibc-localedef-mmap.patch
  ApplyPatch 1070_all_glibc-fadvise64_64.patch
  ApplyPatch 1075_all_glibc-section-comments.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1080_all_glibc-no-inline-gmon.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1085_all_glibc-2.9-check_native-headers.patch
  ApplyPatch 1090_all_glibc-2.3.6-fix-pr631.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1095_all_glibc-2.9-assume-pipe2.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1100_all_glibc-2.3.3-china.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1103_all_glibc-new-valencian-locale.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1120_all_glibc-2.11-longjmp-chk-fallback.patch
  patch -p0 --verbose -i ${SB_PATCHDIR}/1130_all_glibc-2.4-undefine-__i686.patch
  ApplyPatch 1160_all_glibc-2.8-nscd-one-fork.patch
  ApplyPatch 3020_all_glibc-tests-sandbox-libdl-paths.patch
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

set +e +o pipefail
