
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

  ApplyPatch 0020_all_glibc-tweak-rfc1918-lookup.patch
  ApplyPatch 0052_all_glibc-2.14-resolv-hp-assert.patch
  ApplyPatch 0055_all_glibc-2.16-x32-malloc-align.patch
  ApplyPatch 0068_all_glibc-2.16-glibc-revert-fseek-on-fclose.patch
  ApplyPatch 0070_all_glibc-2.16-sunrpc-bootstrap.patch
  ApplyPatch 0080_all_glibc-2.16-revert-x86_64-eagain-pthread_cond_wait.patch
  ApplyPatch 0085_all_glibc-disable-ldconfig.patch
  ApplyPatch 1005_all_glibc-sigaction.patch
  ApplyPatch 1008_all_glibc-2.16-fortify.patch
  ApplyPatch 1040_all_2.3.3-localedef-fix-trampoline.patch
  ApplyPatch 1055_all_glibc-resolv-dynamic.patch
  ApplyPatch 1070_all_glibc-fadvise64_64.patch
  ApplyPatch 1095_all_glibc-2.14-assume-pipe2-dup3.patch
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
ApplyPatch glibc-2.6-nice_fix.patch.gz
ApplyPatch glibc-2.8-ENOTTY-fr-translation.patch.gz
ApplyPatch glibc-2.3.5-biarch-utils.patch.gz
ApplyPatch glibc-2.16-multiarch.patch
ApplyPatch glibc-2.3.6-pt_BR-i18nfixes.patch.gz

# master
ApplyPatch 0001-Add-cosh-tests-for-bug-14273.patch
ApplyPatch 0002-Fix-float-range-reduction-problems-bug-14283.patch
ApplyPatch 0003-Avoid-use-of-libgcc_s-and-libgcc_eh-when-building-gl.patch
ApplyPatch 0001-Fix-ctan-ctanh-of-subnormals-in-round-upwards-mode-b.patch
ApplyPatch 0001-Fix-csqrt-underflow-bugs-14157-14331.patch
ApplyPatch 0001-Fix-expm1-spurious-underflow-exceptions-bug-6778.patch
ApplyPatch 0001-Fix-tanf-underflow-close-to-pi-4-bug-14154.patch
ApplyPatch 0001-Fix-clog-clog10-spurious-underflow-exceptions-bug-14.patch
ApplyPatch 0001-Merge-_sigsys-changes-from-Linux-3.5.patch
ApplyPatch 0002-Merge-Linux-3.5-epoll-changes.patch
ApplyPatch 0003-Merge-Linux-3.5-ptrace-changes.patch
ApplyPatch 0001-Improve-clog-clog10-handling-of-values-with-real-or-.patch
ApplyPatch 0001-Update-i386-ULPs.patch
ApplyPatch 0001-Update-x86-64-ULPs.patch
ApplyPatch 0002-Another-ULPs-update.patch
ApplyPatch 0001-Fix-BZ-14090-md5-sha512-with-large-sizes.patch
ApplyPatch 0002-Add-testcase-for-BZ-14090-md5-sha512-with-large-size.patch
ApplyPatch 0001-Fix-segmentation-fault-in-strncasecmp-for-i686.patch
ApplyPatch 0001-Fix-strtod-integer-buffer-overflow-bug-14459.patch
ApplyPatch 0002-Fix-strtod-rounding-bug-3479.patch
ApplyPatch 0003-Fix-sign-of-zero-on-strtod-underflow-bug-14519.patch
ApplyPatch 0001-Fix-sem_post-race-bug-14532.patch
ApplyPatch 0001-Check-for-gawk-3.0-bug-13412.patch
ApplyPatch 0001-Correctly-handle-Motorola-extended-float-format-in-t.patch
ApplyPatch 0001-Use-LDBL_MIN_EXP-to-distinguish-Intel-and-Motorola-e.patch
ApplyPatch 0001-Improve-C-header-location-detection-bug-13966.patch
ApplyPatch 0001-Increase-timeout-for-stdlib-tst-strtod-overflow.patch
ApplyPatch 0001-Fix-iogetdelim.c-latent-integer-overflow-bug-9914.patch
ApplyPatch 0001-Fix-strtod-test-for-values-above-maximum-for-IBM-lon.patch
ApplyPatch 0001-Make-printf-respect-the-rounding-mode-for-decimal-ou.patch
ApplyPatch 0001-Make-printf-respect-the-rounding-mode-for-hex-output.patch
ApplyPatch 0001-Make-strtod-respect-the-rounding-mode-bug-14518.patch
ApplyPatch 0001-BZ-14583.patch
ApplyPatch 0001-Use-size_t-instead-of-int-for-internal-variables-in-.patch
ApplyPatch 0001-Fix-sign-of-exact-zero-return-from-fma-bug-14638.patch
ApplyPatch 0002-Fix-sign-of-inexact-zero-return-from-fma-bug-14645.patch
ApplyPatch 0003-Fix-exception-table-for-i386-pthread_cond_wait.patch
ApplyPatch 0001-Fix-strtod-handling-of-underflow-bug-14047.patch

set +e +o pipefail
