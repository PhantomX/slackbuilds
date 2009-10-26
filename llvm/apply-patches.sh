  
SB_PATCHDIR=${CWD}/patches

# http://llvm.org/bugs/show_bug.cgi?id=3153
zcat ${SB_PATCHDIR}/llvm-2.6-destdir.patch.gz | patch -p0 -E --backup --verbose || exit 1
( cd tools/clang || exit 1
zcat ${SB_PATCHDIR}/llvm-2.6-destdir-clang.patch.gz | patch -p0 -E --backup --verbose || exit 1
) || exit 1
# http://llvm.org/bugs/show_bug.cgi?id=4911
zcat ${SB_PATCHDIR}/llvm-2.5-tclsh_check.patch.gz | patch -p1 -E --backup --verbose || exit 1
# Data files should be installed with timestamps preserved
zcat ${SB_PATCHDIR}/llvm-2.6-timestamp.patch.gz | patch -p1 -E --backup --verbose || exit 1
