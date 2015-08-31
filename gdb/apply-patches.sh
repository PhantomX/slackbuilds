#!/bin/sh

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
# The merged branch `archer' of: http://sourceware.org/gdb/wiki/ProjectArcher
ApplyPatch gdb-archer.patch

# Backported fixups post the source tarball.
#Xdrop: Just backports.
#ApplyPatch gdb-upstream.patch

# VLA (Fortran dynamic arrays) from Intel + archer-jankratochvil-vla tests.
ApplyPatch gdb-vla-intel.patch
ApplyPatch gdb-vla-intel-logical-not.patch
ApplyPatch gdb-vla-intel-stringbt-fix.patch
ApplyPatch gdb-vla-intel-04of23-fix.patch

# Work around out-of-date dejagnu that does not have KFAIL
ApplyPatch gdb-6.3-rh-dummykfail-20041202.patch.gz

# Better parse 64-bit PPC system call prologues.
ApplyPatch gdb-6.3-ppc64syscall-20040622.patch

# Include the pc's section when doing a symbol lookup so that the
# correct symbol is found.
ApplyPatch gdb-6.3-ppc64displaysymbol-20041124.patch.gz

# Add a wrapper script to GDB that implements pstack using the
# --readnever option.
ApplyPatch gdb-6.3-gstack-20050411.patch

# VSYSCALL and PIE
#=fedoratest
ApplyPatch gdb-6.3-test-pie-20050107.patch

# Get selftest working with sep-debug-info
ApplyPatch gdb-6.3-test-self-20050110.patch

# Test support of multiple destructors just like multiple constructors
ApplyPatch gdb-6.3-test-dtorfix-20050121.patch

# Fix to support executable moving
ApplyPatch gdb-6.3-test-movedir-20050125.patch

# Test sibling threads to set threaded watchpoints for x86 and x86-64
ApplyPatch gdb-6.3-threaded-watchpoints2-20050225.patch

# Do not issue warning message about first page of storage for ia64 gcore
ApplyPatch gdb-6.3-ia64-gcore-page0-20050421.patch

# IA64 sigtramp prev register patch
ApplyPatch gdb-6.3-ia64-sigtramp-frame-20050708.patch.gz

# Notify observers that the inferior has been created
ApplyPatch gdb-6.3-inferior-notification-20050721.patch

# Fix ia64 info frame bug
ApplyPatch gdb-6.3-ia64-info-frame-fix-20050725.patch

# Verify printing of inherited members test
ApplyPatch gdb-6.3-inheritancetest-20050726.patch

# Add readnever option
ApplyPatch gdb-6.3-readnever-20050907.patch

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
ApplyPatch gdb-6.5-BEA-testsuite.patch

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
ApplyPatch gdb-6.6-bz230000-power6-disassembly-test.patch

# Temporary support for shared libraries >2GB on 64bit hosts. (BZ 231832)
ApplyPatch gdb-6.3-bz231832-obstack-2gb.patch

# Allow running `/usr/bin/gcore' with provided but inaccessible tty (BZ 229517).
ApplyPatch gdb-6.6-bz229517-gcore-without-terminal.patch

# Notify user of a child forked process being detached (BZ 235197).
ApplyPatch gdb-6.6-bz235197-fork-detach-info.patch

# Avoid too long timeouts on failing cases of "annota1.exp annota3.exp".
ApplyPatch gdb-6.6-testsuite-timeouts.patch

# Support for stepping over PPC atomic instruction sequences (BZ 237572).
ApplyPatch gdb-6.6-bz237572-ppc-atomic-sequence-test.patch.gz

# Make upstream `set scheduler-locking step' as default.
ApplyPatch gdb-6.6-scheduler_locking-step-is-default.patch

# Test kernel VDSO decoding while attaching to an i386 process.
ApplyPatch gdb-6.3-attach-see-vdso-test.patch

# Test leftover zombie process (BZ 243845).
ApplyPatch gdb-6.5-bz243845-stale-testing-zombie-test.patch

# New locating of the matching binaries from the pure core file (build-id).
#=push
ApplyPatch gdb-6.6-buildid-locate.patch

# Fix loading of core files without build-ids but with build-ids in executables.
#=push
ApplyPatch gdb-6.6-buildid-locate-solib-missing-ids.patch

#=push
ApplyPatch gdb-6.6-buildid-locate-rpm.patch

# Fix displaying of numeric char arrays as strings (BZ 224128).
ApplyPatch gdb-6.7-charsign-test.patch

# Test PPC hiding of call-volatile parameter register.
ApplyPatch gdb-6.7-ppc-clobbered-registers-O2-test.patch

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
ApplyPatch gdb-6.3-mapping-zero-inode-test.patch

# Test a crash on `focus cmd', `focus prev' commands.
ApplyPatch gdb-6.3-focus-cmd-prev-test.patch.gz

# Test various forms of threads tracking across exec() (BZ 442765).
ApplyPatch gdb-6.8-bz442765-threaded-exec-test.patch

# Silence memcpy check which returns false positive (sparc64)
ApplyPatch gdb-6.8-sparc64-silence-memcpy-check.patch

# Test a crash on libraries missing the .text section.
ApplyPatch gdb-6.5-section-num-fixup-test.patch.gz

# Fix register assignments with no GDB stack frames (BZ 436037).
ApplyPatch gdb-6.8-bz436037-reg-no-longer-active.patch.gz

# Make the GDB quit processing non-abortable to cleanup everything properly.
ApplyPatch gdb-6.8-quit-never-aborts.patch

# Test the watchpoints conditionals works.
ApplyPatch gdb-6.8-watchpoint-conditionals-test.patch.gz

# Fix resolving of variables at locations lists in prelinked libs (BZ 466901).
ApplyPatch gdb-6.8-bz466901-backtrace-full-prelinked.patch

# New test for step-resume breakpoint placed in multiple threads at once.
ApplyPatch gdb-simultaneous-step-resume-breakpoint-test.patch.gz

# Fix GNU/Linux core open: Can't read pathname for load map: Input/output error.
ApplyPatch gdb-core-open-vdso-warning.patch

# Fix syscall restarts for amd64->i386 biarch.
ApplyPatch gdb-x86_64-i386-syscall-restart.patch

# Fix stepping with OMP parallel Fortran sections (BZ 533176).
ApplyPatch gdb-bz533176-fortran-omp-step.patch

# Fix regression by python on ia64 due to stale current frame.
ApplyPatch gdb-follow-child-stale-parent.patch.gz

# Workaround ccache making lineno non-zero for command-line definitions.
ApplyPatch gdb-ccache-workaround.patch

#=maybepush: May get obsoleted by Tom's unrelocated objfiles patch.
ApplyPatch gdb-archer-pie-addons.patch
#=push+work: Breakpoints disabling matching should not be based on address.
ApplyPatch gdb-archer-pie-addons-keep-disabled.patch

# Testcase for "Do not make up line information" fix by Daniel Jacobowitz.
ApplyPatch gdb-lineno-makeup-test.patch

# Test power7 ppc disassembly.
ApplyPatch gdb-ppc-power7-test.patch

# Fix i386+x86_64 rwatch+awatch before run, regression against 6.8 (BZ 541866).
ApplyPatch gdb-bz541866-rwatch-before-run.patch

# Workaround non-stop moribund locations exploited by kernel utrace (BZ 590623).
ApplyPatch gdb-moribund-utrace-workaround.patch

# Fix follow-exec for C++ programs (bugreported by Martin Stransky).
ApplyPatch gdb-archer-next-over-throw-cxx-exec.patch

# Backport DWARF-4 support (BZ 601887, Tom Tromey).
ApplyPatch gdb-bz601887-dwarf4-rh-test.patch

# [delayed-symfile] Test a backtrace regression on CFIs without DIE (BZ 614604).
#=fedoratest
ApplyPatch gdb-test-bt-cfi-without-die.patch

# Provide /usr/bin/gdb-add-index for rpm-build (Tom Tromey).
ApplyPatch gdb-gdb-add-index-script.patch

# Out of memory is just an error, not fatal (uninitialized VLS vars, BZ 568248).
ApplyPatch gdb-bz568248-oom-is-error.patch

# Verify GDB Python built-in function gdb.solib_address exists (BZ # 634108).
#=fedoratest
ApplyPatch gdb-bz634108-solib_address.patch

# New test gdb.arch/x86_64-pid0-core.exp for kernel PID 0 cores (BZ 611435).
#=fedoratest
ApplyPatch gdb-test-pid0-core.patch

# [archer-tromey-delayed-symfile] New test gdb.dwarf2/dw2-aranges.exp.
# =fedoratest
ApplyPatch gdb-test-dw2-aranges.patch

# [archer-keiths-expr-cumulative+upstream] Import C++ testcases.
# =fedoratest
ApplyPatch gdb-test-expr-cumulative-archer.patch

ApplyPatch gdb-7.2.50-sparc-add-workaround-to-broken-debug-files.patch

# Work around PR libc/13097 "linux-vdso.so.1" warning message.
#=push
ApplyPatch gdb-glibc-vdso-workaround.patch

# Hack for proper PIE run of the testsuite.
#=push+work
ApplyPatch gdb-runtest-pie-override.patch

# Workaround crashes from stale frame_info pointer (BZ 804256).
ApplyPatch gdb-stale-frame_info.patch

# Workaround PR libc/14166 for inferior calls of strstr.
#=push+work: But push it to glibc.
ApplyPatch gdb-glibc-strstr-workaround.patch

# Include testcase for `Unable to see a variable inside a module (XLF)' (BZ 823789).
#=fedoratest
#+ppc
ApplyPatch gdb-rhel5.9-testcase-xlf-var-inside-mod.patch

# Testcase for `Setting solib-absolute-prefix breaks vDSO' (BZ 818343).
#=fedoratest
ApplyPatch gdb-rhbz-818343-set-solib-absolute-prefix-testcase.patch

# Fix "GDB cannot access struct member whose offset is larger than 256MB"
# (RH BZ 795424).
#=push+work
ApplyPatch gdb-rhbz795424-bitpos-20of25.patch
ApplyPatch gdb-rhbz795424-bitpos-21of25.patch
ApplyPatch gdb-rhbz795424-bitpos-22of25.patch
ApplyPatch gdb-rhbz795424-bitpos-23of25.patch
ApplyPatch gdb-rhbz795424-bitpos-25of25.patch
ApplyPatch gdb-rhbz795424-bitpos-25of25-test.patch
ApplyPatch gdb-rhbz795424-bitpos-lazyvalue.patch

# Import regression test for `gdb/findvar.c:417: internal-error:
# read_var_value: Assertion `frame' failed.' (RH BZ 947564) from RHEL 6.5.
#=fedoratest
ApplyPatch gdb-rhbz947564-findvar-assertion-frame-failed-testcase.patch

# Fix crash of -readnow /usr/lib/debug/usr/bin/gnatbind.debug (BZ 1069211).
ApplyPatch gdb-gnat-dwarf-crash-3of3.patch

ApplyPatch gdb-archer-vla-tests.patch

# Continue backtrace even if a frame filter throws an exception (Phil Muldoon).
ApplyPatch gdb-btrobust.patch

# Display Fortran strings in backtraces.
ApplyPatch gdb-fortran-frame-string.patch

# Fix Python GIL with gdb.execute("continue") (Phil Muldoon, BZ 1116957).
ApplyPatch gdb-python-gil.patch

# Fix jit-reader.h for multi-lib.
ApplyPatch gdb-jit-reader-multilib.patch

### END Fedora

set +e +o pipefail
