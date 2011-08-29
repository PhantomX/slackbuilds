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

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

ApplyPatch gdb-upstream.patch

# The merged branch `archer' of: http://sourceware.org/gdb/wiki/ProjectArcher
ApplyPatch gdb-archer.patch

# Work around out-of-date dejagnu that does not have KFAIL
ApplyPatch gdb-6.3-rh-dummykfail-20041202.patch.gz

# Use convert_from_func_ptr_addr on the solib breakpoint address;
# simplifies and makes more consistent the logic.
ApplyPatch gdb-6.3-ppcdotsolib-20041022.patch.gz

# Better parse 64-bit PPC system call prologues.
ApplyPatch gdb-6.3-ppc64syscall-20040622.patch

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

# VSYSCALL and PIE
#=fedoratest
ApplyPatch gdb-6.3-test-pie-20050107.patch

# Get selftest working with sep-debug-info
ApplyPatch gdb-6.3-test-self-20050110.patch.gz

# Test support of multiple destructors just like multiple constructors
ApplyPatch gdb-6.3-test-dtorfix-20050121.patch

# Fix to support executable moving
ApplyPatch gdb-6.3-test-movedir-20050125.patch

# Fix gcore for threads
ApplyPatch gdb-6.3-gcore-thread-20050204.patch.gz

# Stop while intentionally stepping and the thread exit is met.
ApplyPatch gdb-6.6-step-thread-exit.patch
ApplyPatch gdb-6.3-step-thread-exit-20050211-test.patch

# Prevent gdb from being pushed into background
ApplyPatch gdb-6.3-terminal-fix-20050214.patch.gz

# Test sibling threads to set threaded watchpoints for x86 and x86-64
ApplyPatch gdb-6.3-threaded-watchpoints2-20050225.patch

# Do not issue warning message about first page of storage for ia64 gcore
ApplyPatch gdb-6.3-ia64-gcore-page0-20050421.patch

# IA64 sigtramp prev register patch
ApplyPatch gdb-6.3-ia64-sigtramp-frame-20050708.patch.gz

# IA64 gcore speed-up patch
ApplyPatch gdb-6.3-ia64-gcore-speedup-20050714.patch.gz

# Notify observers that the inferior has been created
ApplyPatch gdb-6.3-inferior-notification-20050721.patch

# Fix ia64 info frame bug
ApplyPatch gdb-6.3-ia64-info-frame-fix-20050725.patch

# Verify printing of inherited members test
ApplyPatch gdb-6.3-inheritancetest-20050726.patch

# Add readnever option
ApplyPatch gdb-6.3-readnever-20050907.patch

# Fix ia64 gdb problem with user-specified SIGILL handling
ApplyPatch gdb-6.3-ia64-sigill-20051115.patch

# Fix debuginfo addresses resolving for --emit-relocs Linux kernels (BZ 203661).
ApplyPatch gdb-6.5-bz203661-emit-relocs.patch

# Support TLS symbols (+`errno' suggestion if no pthread is found) (BZ 185337).
ApplyPatch gdb-6.5-bz185337-resolve-tls-without-debuginfo-v2.patch

# Fix TLS symbols resolving for shared libraries with a relative pathname.
# The testsuite needs `gdb-6.5-tls-of-separate-debuginfo.patch.gz'.
ApplyPatch gdb-6.5-sharedlibrary-path.patch.gz

# Suggest fixing your target architecture for gdbserver(1) (BZ 190810).
# FIXME: It could be autodetected.
ApplyPatch gdb-6.5-bz190810-gdbserver-arch-advice.patch.gz

# Improved testsuite results by the testsuite provided by the courtesy of BEA.
ApplyPatch gdb-6.5-BEA-testsuite.patch.gz

# Testcase for deadlocking on last address space byte; for corrupted backtraces.
ApplyPatch gdb-6.5-last-address-space-byte-test.patch.gz

ApplyPatch gdb-6.5-readline-long-line-crash-test.patch.gz

# Fix bogus 0x0 unwind of the thread's topmost function clone(3) (BZ 216711).
ApplyPatch gdb-6.5-bz216711-clone-is-outermost.patch

# Try to reduce sideeffects of skipping ppc .so libs trampolines (BZ 218379).
ApplyPatch gdb-6.5-bz218379-ppc-solib-trampoline-test.patch.gz

# Fix lockup on trampoline vs. its function lookup; unreproducible (BZ 218379).
ApplyPatch gdb-6.5-bz218379-solib-trampoline-lookup-lock-fix.patch

# Find symbols properly at their original (included) file (BZ 109921).
ApplyPatch gdb-6.5-bz109921-DW_AT_decl_file-test.patch.gz

# Update PPC unwinding patches to their upstream variants (BZ 140532).
ApplyPatch gdb-6.3-bz140532-ppc-unwinding-test.patch

# Testcase for exec() from threaded program (BZ 202689).
ApplyPatch gdb-6.3-bz202689-exec-from-pthread-test.patch

# Testcase for PPC Power6/DFP instructions disassembly (BZ 230000).
ApplyPatch gdb-6.6-bz230000-power6-disassembly-test.patch.gz

# Temporary support for shared libraries >2GB on 64bit hosts. (BZ 231832)
ApplyPatch gdb-6.3-bz231832-obstack-2gb.patch

# Allow running `/usr/bin/gcore' with provided but inaccessible tty (BZ 229517).
ApplyPatch gdb-6.6-bz229517-gcore-without-terminal.patch

# Notify user of a child forked process being detached (BZ 235197).
ApplyPatch gdb-6.6-bz235197-fork-detach-info.patch

# Avoid too long timeouts on failing cases of "annota1.exp annota3.exp".
ApplyPatch gdb-6.6-testsuite-timeouts.patch.gz

# Support for stepping over PPC atomic instruction sequences (BZ 237572).
ApplyPatch gdb-6.6-bz237572-ppc-atomic-sequence-test.patch.gz

# Make upstream `set scheduler-locking step' as default.
ApplyPatch gdb-6.6-scheduler_locking-step-is-default.patch

# Test kernel VDSO decoding while attaching to an i386 process.
ApplyPatch gdb-6.3-attach-see-vdso-test.patch

# Do not hang on exit of a thread group leader (BZ 247354).
ApplyPatch gdb-6.6-bz247354-leader-exit-fix.patch.gz
ApplyPatch gdb-6.6-bz247354-leader-exit-test.patch.gz

# Test leftover zombie process (BZ 243845).
ApplyPatch gdb-6.5-bz243845-stale-testing-zombie-test.patch

# New locating of the matching binaries from the pure core file (build-id).
#=push
ApplyPatch gdb-6.6-buildid-locate.patch

# Fix displaying of numeric char arrays as strings (BZ 224128).
ApplyPatch gdb-6.7-charsign-test.patch

# Test PPC hiding of call-volatile parameter register.
ApplyPatch gdb-6.7-ppc-clobbered-registers-O2-test.patch

# Testsuite fixes for more stable/comparable results.
ApplyPatch gdb-6.7-testsuite-stable-results.patch

# Test ia64 memory leaks of the code using libunwind.
ApplyPatch gdb-6.5-ia64-libunwind-leak-test.patch

# Test hiding unexpected breakpoints on intentional step commands.
ApplyPatch gdb-6.5-missed-trap-on-step-test.patch

# Support DW_TAG_interface_type the same way as DW_TAG_class_type (BZ 426600).
ApplyPatch gdb-6.7-bz426600-DW_TAG_interface_type-test.patch

# Test gcore memory and time requirements for large inferiors.
ApplyPatch gdb-6.5-gcore-buffer-limit-test.patch

# Test debugging statically linked threaded inferiors (BZ 239652).
#  - It requires recent glibc to work in this case properly.
ApplyPatch gdb-6.6-threads-static-test.patch

# Test GCORE for shmid 0 shared memory mappings.
ApplyPatch gdb-6.3-mapping-zero-inode-test.patch.gz

# Test a crash on `focus cmd', `focus prev' commands.
ApplyPatch gdb-6.3-focus-cmd-prev-test.patch.gz

# Test various forms of threads tracking across exec() (BZ 442765).
ApplyPatch gdb-6.8-bz442765-threaded-exec-test.patch

# Silence memcpy check which returns false positive (sparc64)
ApplyPatch gdb-6.8-sparc64-silence-memcpy-check.patch.gz

# Test a crash on libraries missing the .text section.
ApplyPatch gdb-6.5-section-num-fixup-test.patch.gz

# Create a single binary `gdb' autodetecting --tui by its argv[0].
ApplyPatch gdb-6.8-tui-singlebinary.patch.gz

# Fix PRPSINFO in the core files dumped by gcore (BZ 254229).
ApplyPatch gdb-6.8-bz254229-gcore-prpsinfo.patch

# Fix register assignments with no GDB stack frames (BZ 436037).
ApplyPatch gdb-6.8-bz436037-reg-no-longer-active.patch.gz

# Make the GDB quit processing non-abortable to cleanup everything properly.
ApplyPatch gdb-6.8-quit-never-aborts.patch

# Fix attaching to stopped processes and/or pending signals.
ApplyPatch gdb-6.8-attach-signalled-detach-stopped.patch

# Test the watchpoints conditionals works.
ApplyPatch gdb-6.8-watchpoint-conditionals-test.patch.gz

# Fix resolving of variables at locations lists in prelinked libs (BZ 466901).
ApplyPatch gdb-6.8-bz466901-backtrace-full-prelinked.patch

# Fix parsing elf64-i386 files for kdump PAE vmcore dumps (BZ 457187).
# - Turn on 64-bit BFD support, globally enable AC_SYS_LARGEFILE.
ApplyPatch gdb-6.8-bz457187-largefile-test.patch

# New test for step-resume breakpoint placed in multiple threads at once.
ApplyPatch gdb-simultaneous-step-resume-breakpoint-test.patch.gz

# Fix GNU/Linux core open: Can't read pathname for load map: Input/output error.
ApplyPatch gdb-core-open-vdso-warning.patch

# Fix syscall restarts for amd64->i386 biarch.
ApplyPatch gdb-x86_64-i386-syscall-restart.patch.gz

# Fix stepping with OMP parallel Fortran sections (BZ 533176).
ApplyPatch gdb-bz533176-fortran-omp-step.patch

# Fix regression by python on ia64 due to stale current frame.
ApplyPatch gdb-follow-child-stale-parent.patch.gz

# Workaround ccache making lineno non-zero for command-line definitions.
ApplyPatch gdb-ccache-workaround.patch

# Implement 'info common' for Fortran.
ApplyPatch gdb-fortran-common-reduce.patch
ApplyPatch gdb-fortran-common.patch

#=maybepush: May get obsoleted by Tom's unrelocated objfiles patch.
ApplyPatch gdb-archer-pie-addons.patch
#=push+work: Breakpoints disabling matching should not be based on address.
ApplyPatch gdb-archer-pie-addons-keep-disabled.patch

# Testcase for "Do not make up line information" fix by Daniel Jacobowitz.
ApplyPatch gdb-lineno-makeup-test.patch

# Test power7 ppc disassembly.
ApplyPatch gdb-ppc-power7-test.patch

# Revert: Add -Wunused-function to compile flags.
ApplyPatch gdb-unused-revert.patch

# Fix i386+x86_64 rwatch+awatch before run, regression against 6.8 (BZ 541866).
ApplyPatch gdb-bz541866-rwatch-before-run.patch

# Workaround non-stop moribund locations exploited by kernel utrace (BZ 590623).
ApplyPatch gdb-moribund-utrace-workaround.patch

# Fix follow-exec for C++ programs (bugreported by Martin Stransky).
ApplyPatch gdb-archer-next-over-throw-cxx-exec.patch

# Backport DWARF-4 support (BZ 601887, Tom Tromey).
ApplyPatch gdb-bz601887-dwarf4-rh-test.patch

# Print 2D C++ vectors as matrices (BZ 562763, sourceware10659, Chris Moller).
ApplyPatch gdb-bz562763-pretty-print-2d-vectors.patch

# [delayed-symfile] Test a backtrace regression on CFIs without DIE (BZ 614604).
#=fedoratest
ApplyPatch gdb-test-bt-cfi-without-die.patch

# Provide /usr/bin/gdb-add-index for rpm-build (Tom Tromey).
ApplyPatch gdb-gdb-add-index-script.patch

# Out of memory is just an error, not fatal (uninitialized VLS vars, BZ 568248).
ApplyPatch gdb-bz568248-oom-is-error.patch

# Fix gcore writer for -Wl,-z,relro (PR corefiles/11804).
#=push: There is different patch on gdb-patches, waiting now for resolution in kernel.
ApplyPatch gdb-bz623749-gcore-relro.patch

# Fix lost siginfo_t in linux-nat (BZ 592031).
#=push
ApplyPatch gdb-bz592031-siginfo-lost-4of5.patch
#=push
ApplyPatch gdb-bz592031-siginfo-lost-5of5.patch

# Verify GDB Python built-in function gdb.solib_address exists (BZ # 634108).
#=fedoratest
ApplyPatch gdb-bz634108-solib_address.patch

# New testcase py-prettyprint.exp:print hint_error (for BZ 611569, BZ 629236).
#=fedoratest
ApplyPatch gdb-test-pp-hint-error.patch

# New test gdb.arch/x86_64-pid0-core.exp for kernel PID 0 cores (BZ 611435).
#=fedoratest
ApplyPatch gdb-test-pid0-core.patch

# [archer-tromey-delayed-symfile] New test gdb.dwarf2/dw2-aranges.exp.
# =fedoratest
ApplyPatch gdb-test-dw2-aranges.patch

# [archer-keiths-expr-cumulative+upstream] Import C++ testcases.
# =fedoratest
ApplyPatch gdb-test-expr-cumulative-archer.patch

# Temporary fix of F15 gcc-4.6 child DIEs of DW_TAG_typedef (BZ 672230).
# =push
ApplyPatch gdb-gcc46-typedef.patch

# Workaround gcc-4.6 stdarg false prologue end (GDB PR 12435 + GCC PR 47471).
# =push
ApplyPatch gdb-gcc46-stdarg-prologue.patch

# Fix attach/core-load of {,un}prelinked i386 libs (bugreport by Michal Toman).
ApplyPatch gdb-prelink-rela.patch

# Fix threading internal error on corrupted memory (BZ 677654).
ApplyPatch gdb-core-thread-internalerr-1of3.patch
ApplyPatch gdb-core-thread-internalerr-2of3.patch
ApplyPatch gdb-core-thread-internalerr-3of3.patch

ApplyPatch gdb-7.2.50-sparc-add-workaround-to-broken-debug-files.patch

# Fix case insensitive symbols for Fortran by iFort (BZ 645773).
ApplyPatch gdb-bz645773-case-insensitive-1of5.patch
ApplyPatch gdb-bz645773-case-insensitive-2of5.patch
ApplyPatch gdb-bz645773-case-insensitive-3of5.patch
ApplyPatch gdb-bz645773-case-insensitive-4of5.patch

# Bundle readline-6.2 with a workaround of skipped "ask" (BZ 701131).
ApplyPatch gdb-bz701131-readline62-1of3.patch
ApplyPatch gdb-bz701131-readline62-2of3.patch
ApplyPatch gdb-bz701131-readline62-3of3.patch

# [stap] Fix double free.
ApplyPatch gdb-stap-double-free.patch

set +e +o pipefail
