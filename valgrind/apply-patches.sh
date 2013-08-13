
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Set to test (some patches require others, so, is not 100%)
DRYRUN=${DRYRUN:-NO}

if [ "${DRYRUN}" = "YES" ] ; then
  DRYRUN_OPT="--dry-run"
fi

if [ "${VERBOSE}" = "YES" ] ; then
  VERBOSE_OPT="--verbose"
fi

if [ "${SVERBOSE}" = "YES" ] ; then
  set -o xtrace
fi

PATCHCOM="patch ${DRYRUN_OPT} -p1 -F1 -s ${VERBOSE_OPT}"

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
# From Fedora
ApplyPatch ${NAME}-3.8.1-cachegrind-improvements.patch
# KDE#307103 - sys_openat If pathname is absolute, then dirfd is ignored.
ApplyPatch ${NAME}-3.8.1-openat.patch
# KDE#211352 - helgrind races in helgrind's own mythread_wrapper
ApplyPatch ${NAME}-3.8.1-helgrind-race-supp.patch
ApplyPatch ${NAME}-3.8.1-stat_h.patch
# Support really ancient gcc. Check __GNUC__ >= 3 for __builtin_expect.
ApplyPatch ${NAME}-3.8.1-config_h.patch
# KDE#307101 - sys_capget second argument can be NULL 
ApplyPatch ${NAME}-3.8.1-capget.patch
# KDE#263034 - Crash when loading some PPC64 binaries 
ApplyPatch ${NAME}-3.8.1-pie.patch
# configure detection change from armv7* to armv[57]*.
ApplyPatch ${NAME}-3.8.1-enable-armv5.patch
ApplyPatch ${NAME}-3.8.1-ldso-supp.patch
# On x86 GCC 4.6 and later now defaults to -fomit-frame-pointer
# together with emitting unwind info (-fasynchronous-unwind-tables).
# So, try CF info first.
ApplyPatch ${NAME}-3.8.1-x86-backtrace.patch
# KDE#305431 - Use find_buildid shdr fallback for separate .debug files
ApplyPatch ${NAME}-3.8.1-find-buildid.patch
# KDE#305513 - Robustify abbrev reading (part already upstream).
ApplyPatch ${NAME}-3.8.1-abbrev-parsing.patch
# KDE#307038 - DWARF2 CFI reader: unhandled DW_OP_ opcode 0x8 (DW_OP_const1u) 
ApplyPatch ${NAME}-3.8.1-cfi_dw_ops.patch
# On some ppc64 installs these test just hangs
ApplyPatch ${NAME}-3.8.1-gdbserver_tests-mcinvoke-ppc64.patch
# KDE#307285 - x86_amd64 feature test for avx in test suite is wrong
# Should test OSXSAVE first before executing XGETBV.
ApplyPatch ${NAME}-3.8.1-x86_amd64_features-avx.patch
# KDE#307155 - gdbserver_tests/filter_gdb should filter out syscall-template.S
# This is only a real issue when glibc-debuginfo is installed.
ApplyPatch ${NAME}-3.8.1-gdbserver_tests-syscall-template-source.patch
# KDE#307290 - memcheck overlap testcase needs memcpy version filter
ApplyPatch ${NAME}-3.8.1-overlap_memcpy_filter.patch
chmod 755 memcheck/tests/filter_memcpy
# KDE#307729 - pkgconfig support broken valgrind.pc
# valt_load_address=@VALT_LOAD_ADDRESS@
ApplyPatch ${NAME}-3.8.1-pkg-config.patch
# KDE#253519 - Memcheck reports auxv pointer accesses as invalid reads. 
ApplyPatch ${NAME}-3.8.1-proc-auxv.patch
# KDE#307828 - SSE optimized wcscpy, wcscmp, wcsrchr and wcschr trigger
# uninitialised value and/or invalid read warnings
ApplyPatch ${NAME}-3.8.1-wcs.patch
# KDE#308321 - testsuite memcheck filter interferes with gdb_filter
ApplyPatch ${NAME}-3.8.1-filter_gdb.patch
# KDE#308341 - vgdb should report process exit (or fatal signal) 
ApplyPatch ${NAME}-3.8.1-gdbserver_exit.patch
# KDE#164485 - VG_N_SEGNAMES and VG_N_SEGMENTS are (still) too small
ApplyPatch ${NAME}-3.8.1-aspacemgr_VG_N_SEGs.patch
# KDE#308427 - s390 memcheck reports tsearch conditional jump or move
#              depends on uninitialized value [workaround, suppression]
#ApplyPatch ${NAME}-VEX/priv/guest_amd64_toIR.c
# KDE#309427 - SSE optimized stpncpy trigger uninitialised value
ApplyPatch ${NAME}-3.8.1-stpncpy.patch
# KDE#308573 - Internal Valgrind error on 64-bit instruction executed
#              in 32-bit mode
ApplyPatch ${NAME}-3.8.1-ppc-32-mode-64-bit-instr.patch
# KDE#309425 - Provide a --sigill-diagnostics flag to suppress
#              illegal instruction reporting
ApplyPatch ${NAME}-3.8.1-sigill_diag.patch

# Allow building against glibc-2.17. Upstream commit svn 13228.
ApplyPatch ${NAME}-3.8.1-glibc-2.18.patch

# KDE#315441 - sendmsg syscall should ignore unset msghdr msg_flags
ApplyPatch ${NAME}-3.8.1-sendmsg-flags.patch

# KDE#308886 - Missing support for PTRACE_SET/GETREGSET
ApplyPatch ${NAME}-3.8.1-ptrace-setgetregset.patch

# KDE#310424 - --read-var-info does not properly describe static variables
ApplyPatch ${NAME}-3.8.1-static-variables.patch

# KDE#316144, KDE#315959, KDE#316145 - various manpage fixes
ApplyPatch ${NAME}-3.8.1-manpages.patch

# KDE#317091 Use -Wl,-Ttext-segment when static linking to keep build-ids
ApplyPatch ${NAME}-3.8.1-text-segment.patch

# svn revisions 13348 and 13349
ApplyPatch ${NAME}-3.8.1-regtest-fixlets.patch

# KDE#309600 - valgrind is a bit confused about 0-sized sections
ApplyPatch ${NAME}-3.8.1-zero-size-sections.patch

# KDE#320063 Support PTRACE_GET/SET_THREAD_AREA on x86.
ApplyPatch valgrind-3.8.1-ptrace-thread-area.patch

# KDE#320116 Support Linux kernel AF_BLUETOOTH for bind()
ApplyPatch valgrind-3.8.1-af-bluetooth.patch

# Don't include linux/ptrace.h. Upstream commits r13471 and r13482.
ApplyPatch valgrind-3.8.1-ptrace-include-configure.patch

rm -f gdbserver_tests/filter_gdb.orig

set +e +o pipefail
