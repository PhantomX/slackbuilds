
SB_PATCHDIR=${CWD}/patches

# Use old-style locale directories rather than a single (and strangely
# formatted) /usr/lib/locale/locale-archive file:
#zcat ${CWD}/glibc.locale.no-archive.diff.gz | patch -p1 --verbose || exit 1
# The is_IS locale is causing a strange error about the "echn" command
# not existing.  This patch reverts is_IS to the version shipped in
# glibc-2.5:
#zcat ${SB_PATCHDIR}/is_IS.diff.gz | patch -p1 --verbose || exit 1
# Fix NIS netgroups:
zcat ${SB_PATCHDIR}/glibc.nis-netgroups.diff.gz | patch -p1 --verbose || exit 1
# Evidently glibc never expected Linux kernel versions to be in the
# format 1.2.3.4.  This patch makes glibc consider the kernel version
# to be only the first three digit groups found, and drops any
# trailing non-digit characters:
#zcat ${SB_PATCHDIR}/glibc.kernelversion.diff.gz | patch -p1 --verbose || exit 1
# Support ru_RU.CP1251 locale:
#zcat ${CWD}/glibc.ru_RU.CP1251.diff.gz | patch -p1 --verbose || exit 1
# Fix missing MAX macro in getcwd.c:
zcat ${SB_PATCHDIR}/glibc.getcwd.max.macro.diff.gz | patch -p1 --verbose || exit 1
# Gentoo patches
( SB_PATCHDIR=patches

 cat ${SB_PATCHDIR}/0030_all_glibc-respect-env-CPPFLAGS.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/0044_all_glibc-2.10-resolv-nameserver-fallback.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/0055_all_bug-regex29-add-missing-stdio.h-include.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/0056_all_glibc-2.11-preadv-pwritev-fallocate-64bit.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/0058_all_glibc-2.11-memset-fortify-const-warning.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/0066_all_glibc-2.10-malloc-check-race-crash.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/0070_all_glibc-i386-x86_64-revert-clone-cfi.patch | patch -p0 --verbose || exit 1
 cat ${SB_PATCHDIR}/0077_all_i386-glibc-no-fallocate.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/0085_all_glibc-disable-ldconfig.patch | patch -p0 --verbose || exit 1
 cat ${SB_PATCHDIR}/1010_all_glibc-queue-header-updates.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1020_all_glibc-longjmp-chk-hidden-fortify.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1030_all_glibc-manual-no-perl.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1040_all_2.3.3-localedef-fix-trampoline.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1055_all_glibc-resolv-dynamic.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1060_all_glibc-localedef-mmap.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1070_all_glibc-fadvise64_64 | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1073_all_glibc-ldbl-nexttowardf.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1075_all_glibc-section-comments.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1080_all_glibc-no-inline-gmon.patch | patch -p0 --verbose || exit 1
 cat ${SB_PATCHDIR}/1085_all_glibc-2.9-check_native-headers.patch | patch -p0 --verbose || exit 1
 cat ${SB_PATCHDIR}/1090_all_glibc-2.3.6-fix-pr631.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/1095_all_glibc-2.9-assume-pipe2.patch | patch -p0 --verbose || exit 1
 cat ${SB_PATCHDIR}/1100_all_glibc-2.3.3-china.patch | patch -p0 --verbose || exit 1
 cat ${SB_PATCHDIR}/1103_all_glibc-new-valencian-locale.patch | patch -p0 --verbose || exit 1
 cat ${SB_PATCHDIR}/1130_all_glibc-2.4-undefine-__i686.patch | patch -p0 --verbose || exit 1
 cat ${SB_PATCHDIR}/1160_all_glibc-2.8-nscd-one-fork.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/3020_all_glibc-tests-sandbox-libdl-paths.patch | patch -p1 --verbose || exit 1
 cat ${SB_PATCHDIR}/5021_all_2.9-fnmatch.patch | patch -p0 --verbose || exit 1
 cat ${SB_PATCHDIR}/5063_all_glibc-dont-build-timezone.patch | patch -p1 --verbose || exit 1

)
