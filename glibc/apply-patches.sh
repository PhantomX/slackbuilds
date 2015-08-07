
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
  ApplyPatch 00_all_0003-Fix-localedef-segfault-when-run-under-exec-shield-Pa.patch
  ApplyPatch 00_all_0004-reload-etc-resolv.conf-when-it-has-changed.patch
  ApplyPatch 00_all_0005-nptl-support-thread-stacks-that-grow-up.patch
  ApplyPatch 00_all_0006-rtld-do-not-ignore-arch-specific-CFLAGS.patch
  ApplyPatch 00_all_0007-gentoo-support-running-tests-under-sandbox.patch
  ApplyPatch 00_all_0008-gentoo-disable-building-in-timezone-subdir.patch
  ApplyPatch 00_all_0012-disable-PIE-when-checking-for-PIC-default.patch
  ApplyPatch 00_all_0013-nptl-fix-set-but-unused-warning-w-_STACK_GROWS_UP.patch
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
ApplyPatch glibc-rh741105.patch
# Upstream BZ 14247
ApplyPatch glibc-rh827510.patch
# Upstream BZ 14185
ApplyPatch glibc-rh819430.patch
# Fix nscd to use permission names not constants.
ApplyPatch glibc-rh1070416.patch
ApplyPatch glibc-aarch64-tls-fixes.patch
ApplyPatch glibc-aarch64-workaround-nzcv-clobber-in-tlsdesc.patch

# Upstream BZ 18568
ApplyPatch glibc-rh1238412-remove-duplicate-transliterations.patch
ApplyPatch glibc-rh1238412-addition-and-fixes-for-translit_neutral.patch
ApplyPatch glibc-rh1238412-update-the-translit-files-to-unicode-7.0.0.patch
ApplyPatch glibc-rh1238412-add-translit-rules-for-da-nb-nn-sv-locales.patch
ApplyPatch glibc-rh1238412-unicode-8.0.0-update.patch

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
ApplyPatch 0001-Fix-powf-close-to-1-large-bug-18647.patch
ApplyPatch 0002-Also-check-dead-data-category-NULL.patch

set +e +o pipefail
