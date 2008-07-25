
SB_PATCHDIR=${CWD}/patches

# Use old-style locale directories rather than a single (and strangely
# formatted) /usr/lib/locale/locale-archive file:
#zcat ${CWD}/glibc.locale.no-archive.diff.gz | patch -p1 --verbose || exit 1
# The is_IS locale is causing a strange error about the "echn" command
# not existing.  This patch reverts is_IS to the version shipped in
# glibc-2.5:
zcat ${SB_PATCHDIR}/is_IS.diff.gz | patch -p1 --verbose || exit 1
# Fix NIS netgroups:
zcat ${SB_PATCHDIR}/glibc.nis-netgroups.diff.gz | patch -p1 --verbose || exit 1
# Evidently glibc never expected Linux kernel versions to be in the
# format 1.2.3.4.  This patch makes glibc consider the kernel version
# to be only the first three digit groups found, and drops any
# trailing non-digit characters:
zcat ${SB_PATCHDIR}/glibc.kernelversion.diff.gz | patch -p1 --verbose || exit 1
# Support ru_RU.CP1251 locale:
#zcat ${CWD}/glibc.ru_RU.CP1251.diff.gz | patch -p1 --verbose || exit 1
# Fix missing MAX macro in getcwd.c:
zcat ${SB_PATCHDIR}/glibc.getcwd.max.macro.diff.gz | patch -p1 --verbose || exit 1
# Gentoo patches
zcat ${SB_PATCHDIR}/0065_all_glibc-2.7-i386-new-binutils.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/1055_all_glibc-resolv-dynamic.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1058_all_glibc-gnulib-regcomp.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1060_all_glibc-signal-timer-fd.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/1085_all_glibc-omitfp-memmove.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/6417_all_sh-glibc-2.7-broken-nptl-lock-macros.patch.gz | patch -p0 --verbose || exit 1

# some important patches from Debian
zcat ${SB_PATCHDIR}/locale.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/glibc-2.5-localedef_segfault-1.patch.gz | patch -p1 --verbose || exit 1

# Upstream fixes. See sources.redhat.com bugzilla
zcat ${SB_PATCHDIR}/glibc-2.7-bz4781.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/glibc-2.7-bz5375.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/glibc-2.7-bz5382.patch.gz | patch -p1 --verbose || exit 1
zcat ${SB_PATCHDIR}/glibc-2.7-bz5435.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/glibc-2.7-bz5441.patch.gz | patch -p0 --verbose || exit 1
zcat ${SB_PATCHDIR}/glibc-2.7-bz5531.patch.gz | patch -p1 --verbose || exit 1

# Fixes breakage introduced by patch bz5435
zcat ${SB_PATCHDIR}/fix-makecontext.patch.gz | patch -p1 --verbose || exit 1

# fix some broken locales (upstream fixes)
zcat ${SB_PATCHDIR}/fix_broken_locales.patch.gz | patch -p1 --verbose || exit 1

# Update manuals
zcat ${SB_PATCHDIR}/glibc-2.7-branch_update-1A.patch.gz | patch -p1 --verbose || exit 1

