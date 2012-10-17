
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-cachegrind-improvements.patch
# KDE#307103 - sys_openat If pathname is absolute, then dirfd is ignored.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-openat.patch
# KDE#211352 - helgrind races in helgrind's own mythread_wrapper
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-helgrind-race-supp.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-stat_h.patch
# Support really ancient gcc. Check __GNUC__ >= 3 for __builtin_expect.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-config_h.patch
# KDE#307101 - sys_capget second argument can be NULL 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-capget.patch
# KDE#263034 - Crash when loading some PPC64 binaries 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-pie.patch
# configure detection change from armv7* to armv[57]*.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-enable-armv5.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-ldso-supp.patch
# On x86 GCC 4.6 and later now defaults to -fomit-frame-pointer
# together with emitting unwind info (-fasynchronous-unwind-tables).
# So, try CF info first.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-x86-backtrace.patch
# KDE#305431 - Use find_buildid shdr fallback for separate .debug files
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-find-buildid.patch
# KDE#305513 - Robustify abbrev reading (part already upstream).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-abbrev-parsing.patch
# KDE#307038 - DWARF2 CFI reader: unhandled DW_OP_ opcode 0x8 (DW_OP_const1u) 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-cfi_dw_ops.patch
# On some ppc64 installs these test just hangs
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-gdbserver_tests-mcinvoke-ppc64.patch
# KDE#307285 - x86_amd64 feature test for avx in test suite is wrong
# Should test OSXSAVE first before executing XGETBV.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-x86_amd64_features-avx.patch
# KDE#307155 - gdbserver_tests/filter_gdb should filter out syscall-template.S
# This is only a real issue when glibc-debuginfo is installed.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-gdbserver_tests-syscall-template-source.patch
# KDE#307290 - memcheck overlap testcase needs memcpy version filter
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-overlap_memcpy_filter.patch
# Note: Need to make memcheck/tests/filter_memcpy executable
# KDE#307729 - pkgconfig support broken valgrind.pc
# valt_load_address=@VALT_LOAD_ADDRESS@
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-pkg-config.patch
# KDE#253519 - Memcheck reports auxv pointer accesses as invalid reads. 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-proc-auxv.patch
# KDE#307828 - SSE optimized wcscpy, wcscmp, wcsrchr and wcschr trigger
# uninitialised value and/or invalid read warnings
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-wcs.patch
# KDE#308321 - testsuite memcheck filter interferes with gdb_filter
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-filter_gdb.patch
# KDE#308341 - vgdb should report process exit (or fatal signal) 
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-gdbserver_exit.patch
# KDE#164485 - VG_N_SEGNAMES and VG_N_SEGMENTS are (still) too small
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-aspacemgr_VG_N_SEGs.patch
# KDE#308427 - s390 memcheck reports tsearch conditional jump or move
#              depends on uninitialized value [workaround, suppression]
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-s390_tsearch_supp.patch
# KDE#307106 - unhandled instruction bytes: f0 0f c0 02 (lock xadd)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.8.1-xaddb.patch

set +e +o pipefail
