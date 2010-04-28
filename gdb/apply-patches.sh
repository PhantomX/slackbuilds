#!/bin/sh

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
  case "${patch}" in
  *.bz2) bzcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *.gz) zcat "${SB_PATCHDIR}/${patch}" | ${PATCHCOM} ${1+"$@"} ;;
  *) ${PATCHCOM} ${1+"$@"} -i "${SB_PATCHDIR}/${patch}" ;;
  esac
}

ApplyPatch gdb-upstream.patch

# The merged branch `archer' of: http://sourceware.org/gdb/wiki/ProjectArcher
ApplyPatch gdb-archer.patch
ApplyPatch gdb-archer-ada.patch

# Work around out-of-date dejagnu that does not have KFAIL
ApplyPatch gdb-6.3-rh-dummykfail-20041202.patch.gz

# Use convert_from_func_ptr_addr on the solib breakpoint address;
# simplifies and makes more consistent the logic.
ApplyPatch gdb-6.3-ppcdotsolib-20041022.patch.gz

# Better parse 64-bit PPC system call prologues.
ApplyPatch gdb-6.3-ppc64syscall-20040622.patch.gz

# Stop a backtrace when a zero PC is encountered.
ApplyPatch gdb-6.3-framepczero-20040927.patch.gz

# Include the pc's section when doing a symbol lookup so that the
# correct symbol is found.
ApplyPatch gdb-6.3-ppc64displaysymbol-20041124.patch.gz

# Fix upstream `set scheduler-locking step' vs. upstream PPC atomic seqs.
ApplyPatch gdb-6.6-scheduler_locking-step-sw-watchpoints2.patch

# Add a wrapper script to GDB that implements pstack using the
# --readnever option.
ApplyPatch gdb-6.3-gstack-20050411.patch

# Get selftest working with sep-debug-info
ApplyPatch gdb-6.3-test-self-20050110.patch.gz

# Fix for non-threaded watchpoints.
ApplyPatch gdb-6.3-nonthreaded-wp-20050117.patch.gz

# Test support of multiple destructors just like multiple constructors
ApplyPatch gdb-6.3-test-dtorfix-20050121.patch.gz

# Fix to support executable moving
ApplyPatch gdb-6.3-test-movedir-20050125.patch.gz

# Fix gcore for threads
ApplyPatch gdb-6.3-gcore-thread-20050204.patch.gz

# Stop while intentionally stepping and the thread exit is met.
ApplyPatch gdb-6.6-step-thread-exit.patch.gz
ApplyPatch gdb-6.3-step-thread-exit-20050211-test.patch.gz

# Prevent gdb from being pushed into background
ApplyPatch gdb-6.3-terminal-fix-20050214.patch.gz

# Test sibling threads to set threaded watchpoints for x86 and x86-64
ApplyPatch gdb-6.3-threaded-watchpoints2-20050225.patch.gz

# Fix printing of inherited members
ApplyPatch gdb-6.3-inheritance-20050324.patch.gz

# Do not issue warning message about first page of storage for ia64 gcore
ApplyPatch gdb-6.3-ia64-gcore-page0-20050421.patch.gz

# IA64 sigtramp prev register patch
ApplyPatch gdb-6.3-ia64-sigtramp-frame-20050708.patch.gz

# IA64 gcore speed-up patch
ApplyPatch gdb-6.3-ia64-gcore-speedup-20050714.patch.gz

# Notify observers that the inferior has been created
ApplyPatch gdb-6.3-inferior-notification-20050721.patch.gz

# Fix ia64 info frame bug
ApplyPatch gdb-6.3-ia64-info-frame-fix-20050725.patch.gz

# Verify printing of inherited members test
ApplyPatch gdb-6.3-inheritancetest-20050726.patch.gz

# Add readnever option
ApplyPatch gdb-6.3-readnever-20050907.patch

# Fix ia64 gdb problem with user-specified SIGILL handling
ApplyPatch gdb-6.3-ia64-sigill-20051115.patch.gz

# Allow option to continue backtracing past a zero pc value
ApplyPatch gdb-6.3-bt-past-zero-20051201.patch.gz

# Use bigger numbers than int.
ApplyPatch gdb-6.3-large-core-20051206.patch

# Fix debuginfo addresses resolving for --emit-relocs Linux kernels (BZ 203661).
ApplyPatch gdb-6.5-bz203661-emit-relocs.patch

# Security patch: avoid stack overflows in dwarf expression computation.
# CVE-2006-4146
ApplyPatch gdb-6.5-dwarf-stack-overflow.patch.gz

# Support TLS symbols (+`errno' suggestion if no pthread is found) (BZ 185337).
ApplyPatch gdb-6.5-bz185337-resolve-tls-without-debuginfo-v2.patch

# Fix TLS symbols resolving for objects with separate .debug file (-debuginfo).
ApplyPatch gdb-6.5-tls-of-separate-debuginfo.patch.gz

# Fix TLS symbols resolving for shared libraries with a relative pathname.
# The testsuite needs `gdb-6.5-tls-of-separate-debuginfo.patch.gz'.
ApplyPatch gdb-6.5-sharedlibrary-path.patch.gz

# Suggest fixing your target architecture for gdbserver(1) (BZ 190810).
# FIXME: It could be autodetected.
ApplyPatch gdb-6.5-bz190810-gdbserver-arch-advice.patch.gz

# Fix `gcore' command for 32bit inferiors on 64bit hosts.
ApplyPatch gdb-6.5-gcore-i386-on-amd64.patch

# Improved testsuite results by the testsuite provided by the courtesy of BEA.
ApplyPatch gdb-6.5-BEA-testsuite.patch.gz

# Fix readline segfault on excessively long hand-typed lines.
ApplyPatch gdb-6.5-readline-long-line-crash.patch.gz

# Testcase for deadlocking on last address space byte; for corrupted backtraces.
ApplyPatch gdb-6.5-last-address-space-byte-test.patch.gz

ApplyPatch gdb-6.5-readline-long-line-crash-test.patch.gz

# Fix bogus 0x0 unwind of the thread's topmost function clone(3) (BZ 216711).
ApplyPatch gdb-6.5-bz216711-clone-is-outermost.patch

# Try to reduce sideeffects of skipping ppc .so libs trampolines (BZ 218379).
ApplyPatch gdb-6.5-bz218379-ppc-solib-trampoline-fix.patch.gz
ApplyPatch gdb-6.5-bz218379-ppc-solib-trampoline-test.patch.gz

# Fix lockup on trampoline vs. its function lookup; unreproducible (BZ 218379).
ApplyPatch gdb-6.5-bz218379-solib-trampoline-lookup-lock-fix.patch.gz

# Find symbols properly at their original (included) file (BZ 109921).
ApplyPatch gdb-6.5-bz109921-DW_AT_decl_file-test.patch.gz

# Update PPC unwinding patches to their upstream variants (BZ 140532).
ApplyPatch gdb-6.3-bz140532-ppc-unwinding-test.patch.gz

# Testcase for exec() from threaded program (BZ 202689).
ApplyPatch gdb-6.3-bz202689-exec-from-pthread-test.patch.gz

# Testcase for PPC Power6/DFP instructions disassembly (BZ 230000).
ApplyPatch gdb-6.6-bz230000-power6-disassembly-test.patch.gz

# Temporary support for shared libraries >2GB on 64bit hosts. (BZ 231832)
ApplyPatch gdb-6.3-bz231832-obstack-2gb.patch.gz

# Fix prelink(8) testcase for non-root $PATH missing `/usr/sbin' (BZ 225783).
ApplyPatch gdb-6.6-bz225783-prelink-path.patch.gz

# Fix debugging GDB itself - the compiled in source files paths (BZ 225783).
ApplyPatch gdb-6.6-bz225783-gdb-debuginfo-paths.patch.gz

# Allow running `/usr/bin/gcore' with provided but inaccessible tty (BZ 229517).
ApplyPatch gdb-6.6-bz229517-gcore-without-terminal.patch.gz

# Notify user of a child forked process being detached (BZ 235197).
ApplyPatch gdb-6.6-bz235197-fork-detach-info.patch

# New testcase for gcore of 32bit inferiors on 64bit hosts.
ApplyPatch gdb-6.6-gcore32-test.patch

# Avoid too long timeouts on failing cases of "annota1.exp annota3.exp".
ApplyPatch gdb-6.6-testsuite-timeouts.patch.gz

# Support for stepping over PPC atomic instruction sequences (BZ 237572).
ApplyPatch gdb-6.6-bz237572-ppc-atomic-sequence-test.patch.gz

# Make upstream `set scheduler-locking step' as default.
ApplyPatch gdb-6.6-scheduler_locking-step-is-default.patch.gz

# Link with libreadline provided by the operating system.
ApplyPatch gdb-6.6-readline-system.patch.gz

# Test kernel VDSO decoding while attaching to an i386 process.
ApplyPatch gdb-6.3-attach-see-vdso-test.patch.gz

# Do not hang on exit of a thread group leader (BZ 247354).
ApplyPatch gdb-6.6-bz247354-leader-exit-fix.patch.gz
ApplyPatch gdb-6.6-bz247354-leader-exit-test.patch.gz

# Test leftover zombie process (BZ 243845).
ApplyPatch gdb-6.5-bz243845-stale-testing-zombie-test.patch.gz

# Fix displaying of numeric char arrays as strings (BZ 224128).
ApplyPatch gdb-6.7-charsign-test.patch.gz

# Test PPC hiding of call-volatile parameter register.
ApplyPatch gdb-6.7-ppc-clobbered-registers-O2-test.patch.gz

# Testsuite fixes for more stable/comparable results.
ApplyPatch gdb-6.7-testsuite-stable-results.patch

# Test ia64 memory leaks of the code using libunwind.
ApplyPatch gdb-6.5-ia64-libunwind-leak-test.patch.gz

# Test hiding unexpected breakpoints on intentional step commands.
ApplyPatch gdb-6.5-missed-trap-on-step-test.patch.gz

# Support DW_TAG_interface_type the same way as DW_TAG_class_type (BZ 426600).
ApplyPatch gdb-6.7-bz426600-DW_TAG_interface_type-fix.patch.gz
ApplyPatch gdb-6.7-bz426600-DW_TAG_interface_type-test.patch.gz

# Test gcore memory and time requirements for large inferiors.
ApplyPatch gdb-6.5-gcore-buffer-limit-test.patch.gz

# Test debugging statically linked threaded inferiors (BZ 239652).
#  - It requires recent glibc to work in this case properly.
ApplyPatch gdb-6.6-threads-static-test.patch.gz

# Fix #include <asm/ptrace.h> on kernel-headers-2.6.25-0.40.rc1.git2.fc9.x86_64.
ApplyPatch gdb-6.7-kernel-headers-compat.patch.gz

# Test GCORE for shmid 0 shared memory mappings.
ApplyPatch gdb-6.3-mapping-zero-inode-test.patch.gz

# Test a crash on `focus cmd', `focus prev' commands.
ApplyPatch gdb-6.3-focus-cmd-prev-test.patch.gz

# Test various forms of threads tracking across exec() (BZ 442765).
ApplyPatch gdb-6.8-bz442765-threaded-exec-test.patch.gz

# Silence memcpy check which returns false positive (sparc64)
ApplyPatch gdb-6.8-sparc64-silence-memcpy-check.patch.gz

# Fix memory trashing on binaries from GCC Ada (workaround GCC PR 35998).
ApplyPatch gdb-6.8-gcc35998-ada-memory-trash.patch.gz

# Test a crash on libraries missing the .text section.
ApplyPatch gdb-6.5-section-num-fixup-test.patch.gz

# Refuse creating watchpoints of an address value, suggested by Martin Stransky.
ApplyPatch gdb-6.8-constant-watchpoints.patch

# Fix compatibility with recent glibc headers.
ApplyPatch gdb-6.8-glibc-headers-compat.patch.gz

# Create a single binary `gdb' autodetecting --tui by its argv[0].
ApplyPatch gdb-6.8-tui-singlebinary.patch.gz

# Support transparent debugging of inlined functions for an optimized code.
ApplyPatch gdb-6.8-inlining-addon.patch
ApplyPatch gdb-6.8-inlining-by-name.patch.gz

# Fix PRPSINFO in the core files dumped by gcore (BZ 254229).
ApplyPatch gdb-6.8-bz254229-gcore-prpsinfo.patch

# Fix register assignments with no GDB stack frames (BZ 436037).
ApplyPatch gdb-6.8-bz436037-reg-no-longer-active.patch.gz

# Make the GDB quit processing non-abortable to cleanup everything properly.
ApplyPatch gdb-6.8-quit-never-aborts.patch.gz

# Support DW_TAG_constant for Fortran in recent Fedora/RH GCCs.
ApplyPatch gdb-6.8-fortran-tag-constant.patch

# Fix attaching to stopped processes and/or pending signals.
ApplyPatch gdb-6.8-attach-signalled-detach-stopped.patch

# Test the watchpoints conditionals works.
ApplyPatch gdb-6.8-watchpoint-conditionals-test.patch.gz

# Fix resolving of variables at locations lists in prelinked libs (BZ 466901).
ApplyPatch gdb-6.8-bz466901-backtrace-full-prelinked.patch.gz

# Fix parsing elf64-i386 files for kdump PAE vmcore dumps (BZ 457187).
# - Turn on 64-bit BFD support, globally enable AC_SYS_LARGEFILE.
ApplyPatch gdb-6.8-bz457187-largefile-test.patch

# New test for step-resume breakpoint placed in multiple threads at once.
ApplyPatch gdb-simultaneous-step-resume-breakpoint-test.patch.gz

# Fix GNU/Linux core open: Can't read pathname for load map: Input/output error.
ApplyPatch gdb-core-open-vdso-warning.patch.gz

# Fix syscall restarts for amd64->i386 biarch.
ApplyPatch gdb-x86_64-i386-syscall-restart.patch.gz

# Fix stepping with OMP parallel Fortran sections (BZ 533176).
ApplyPatch gdb-bz533176-fortran-omp-step.patch.gz

# Fix regression by python on ia64 due to stale current frame.
ApplyPatch gdb-follow-child-stale-parent.patch.gz

# Workaround ccache making lineno non-zero for command-line definitions.
ApplyPatch gdb-ccache-workaround.patch

# Implement 'info common' for Fortran.
ApplyPatch gdb-fortran-common-reduce.patch
ApplyPatch gdb-fortran-common.patch

# Fix Fortran logical-kind=8 (BZ 465310).
ApplyPatch gdb-fortran-logical8.patch

# Testcase for "Do not make up line information" fix by Daniel Jacobowitz.
ApplyPatch gdb-lineno-makeup-test.patch

# Test power7 ppc disassembly.
ApplyPatch gdb-ppc-power7-test.patch

# Revert: Add -Wunused-function to compile flags.
ApplyPatch gdb-unused-revert.patch

# Fix i386+x86_64 rwatch+awatch before run, regression against 6.8 (BZ 541866).
ApplyPatch gdb-bz541866-rwatch-before-run.patch

# Remove false gdb_assert on $sp underflow.
ApplyPatch gdb-infcall-sp-underflow.patch

# Fix double-free on std::terminate handler (Tom Tromey, BZ 562975).
ApplyPatch gdb-bz562975-std-terminate-double-free.patch

# PIE: Fix back re-reun.
ApplyPatch gdb-pie-rerun.patch

# Do not consider memory error on reading _r_debug->r_map as fatal (BZ 576742).
ApplyPatch gdb-solib-memory-error-nonfatal.patch

# testsuite: Fix unstable results of gdb.base/prelink.exp.
ApplyPatch gdb-6.7-testsuite-stable-results-prelink.patch 

# [patch 1/6] PIE: Attach binary even after re-prelinked underneath
# [patch 2/6] PIE: Attach binary even after ld.so re-prelinked underneath
# [patch 3/6] PIE: Fix occasional error attaching i686 binary
ApplyPatch gdb-pie-1of6-reprelinked-bin.patch
ApplyPatch gdb-pie-2of6-reprelinked-ld.patch
ApplyPatch gdb-pie-3of6-relocate-once.patch

# [expr-cumulative] using-directive: Fix memory leak (Sami Wagiaalla).
ApplyPatch gdb-using-directive-leak.patch

# Fix dangling displays in separate debuginfo (BZ 574483).
ApplyPatch gdb-bz574483-display-sepdebug.patch

# Support AVX registers (BZ 578250).
ApplyPatch gdb-bz578250-avx-01of10.patch
ApplyPatch gdb-bz578250-avx-02of10.patch
ApplyPatch gdb-bz578250-avx-03of10.patch
ApplyPatch gdb-bz578250-avx-04of10.patch
ApplyPatch gdb-bz578250-avx-05of10.patch
ApplyPatch gdb-bz578250-avx-06of10.patch
ApplyPatch gdb-bz578250-avx-07of10.patch
ApplyPatch gdb-bz578250-avx-08of10.patch
ApplyPatch gdb-bz578250-avx-09of10.patch
ApplyPatch gdb-bz578250-avx-10of10.patch
ApplyPatch gdb-bz578250-avx-10of10-ppc.patch

# Fix crash on C++ types in some debug info files (BZ 575292, Keith Seitz).
# Temporarily workaround the crash of BZ 575292 as there was now BZ 585445.
ApplyPatch gdb-bz575292-delayed-physname.patch
ApplyPatch gdb-bz575292-void-workaround.patch

# Pretty printers not well documented (BZ 570635, Tom Tromey, Jan Kratochvil).
ApplyPatch gdb-bz570635-prettyprint-doc1.patch
ApplyPatch gdb-bz570635-prettyprint-doc2.patch

# Fix crash when using GNU IFUNC call from breakpoint condition.
ApplyPatch gdb-bz539590-gnu-ifunc-fix-cond.patch

set +e +o pipefail
