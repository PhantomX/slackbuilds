
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
zcat ${SB_PATCHDIR}/0030_all_glibc-respect-env-CPPFLAGS.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1010_all_glibc-queue-header-updates.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1040_all_2.3.3-localedef-fix-trampoline.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1070_all_glibc-fadvise64_64.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1055_all_glibc-resolv-dynamic.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1080_all_glibc-no-inline-gmon.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/1090_all_glibc-2.3.6-fix-pr631.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1085_all_glibc-2.9-check_native-headers.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/1095_all_glibc-2.9-assume-pipe2.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/1100_all_glibc-2.3.3-china.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/1103_all_glibc-new-valencian-locale.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/1130_all_glibc-2.4-undefine-__i686.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/1160_all_glibc-2.8-nscd-one-fork.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/5063_all_glibc-dont-build-timezone.patch.gz | patch -p1 --verbose || exit 1

# Upstream fixes. See sources.redhat.com bugzilla
zcat ${SB_PATCHDIR}/glibc-2.7-bz4781.patch.gz | patch -p1 --verbose || exit 1

zcat ${SB_PATCHDIR}/glibc-nss_dns-gethostbyname4-disable.patch.gz | patch -p1 --verbose || exit 1
