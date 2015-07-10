
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
PATCH_DRYRUN=${PATCH_DRYRUN:-NO}

unset PATCH_DRYRUN_OPT PATCH_VERBOSE_OPT

[ "${PATCH_DRYRUN}" = "YES" ] && PATCH_DRYRUN_OPT="--dry-run"
[ "${PATCH_VERBOSE}" = "YES" ] && PATCH_VERBOSE_OPT="--verbose"
[ "${PATCH_SVERBOSE}" = "YES" ] && set -o xtrace

PATCHCOM="patch ${PATCH_DRYRUN_OPT} -p1 -F1 -s ${PATCH_VERBOSE_OPT}"

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

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

### Fedora
ApplyPatch ${NAME}-3.9.0-cachegrind-improvements.patch
# KDE#211352 - helgrind races in helgrind's own mythread_wrapper
ApplyPatch ${NAME}-3.9.0-helgrind-race-supp.patch
ApplyPatch ${NAME}-3.9.0-stat_h.patch
ApplyPatch ${NAME}-3.9.0-ldso-supp.patch
# KDE#342795 Internal glibc __GI_mempcpy call should be intercepted
ApplyPatch ${NAME}-3.10.1-mempcpy.patch
# KDE#343802 - s390x memcheck reports spurious conditional jump
ApplyPatch valgrind-3.10-s390-spechelper.patch
# KDE#342038, KDE#343732, KDE#343733, KDE#344007, KDE#344307
# mbind, get_mempolicy, set_mempolicy, flock, setgid, msgget, msgctl,
# msgrcv, msgsnd, accept4, mount, umount2
ApplyPatch valgrind-3.10.1-aarch64-syscalls.patch
# KDE#344007 ppc64 missing accept4 syscall
ApplyPatch valgrind-3.10.1-ppc64-accept4.patch
# KDE#344279 - syscall sendmmsg on arm64 (269) and ppc32/64 (349) unhandled
# KDE#344295 - syscall recvmmsg on arm64 (243) and ppc32/64 (343) unhandled
# KDE#344318 - socketcall should wrap recvmmsg and sendmmsg
ApplyPatch valgrind-3.10.1-send-recv-mmsg.patch
# Upstream valgrind svn r14530
ApplyPatch valgrind-3.10.1-glibc-version-check.patch
# Upstream valgrind svn r15133
ApplyPatch valgrind-3.10-1-ppc64-sigpending.patch
# KDE#343012 - Unhandled syscall 319 (memfd_create)
ApplyPatch valgrind-3.10.1-memfd_create.patch
# KDE#347389 - Add support for the syncfs system call.
ApplyPatch valgrind-3.10.1-syncfs.patch
# Upstream valgrind svn r15304
ApplyPatch valgrind-3.10.1-arm-process_vm_readv_writev.patch
# Upstream valgrind svn r15305
ApplyPatch valgrind-3.10.1-fno-ipa-icf.patch
# Upstream valgrind svn r14780 and r15308
ApplyPatch valgrind-3.10.1-demangle-q.patch
# KDE#345928 callstack only contains current function for small stacks
ApplyPatch valgrind-3.10.1-cfi-redzone.patch
# KDE#344499 Fix compilation for Linux kernel >= 4.
ApplyPatch valgrind-3.10.1-kernel-4.0.patch
# KDE#349941 di_notify_mmap might create wrong start/size DebugInfoMapping
ApplyPatch valgrind-3.10.1-di_notify_mmap.patch
# KDE#349828 memcpy intercepts memmove causing src/dst overlap error
ApplyPatch valgrind-3.10.1-memmove-ld_so-ppc64.patch
# KDE#342841 s390x unrecognized instruction fiebra
ApplyPatch valgrind-3.10.1-s390x-fiebra.patch

### Arch

set +e +o pipefail
