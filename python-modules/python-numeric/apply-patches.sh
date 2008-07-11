
SB_PATCHDIR=${CWD}/patches

# fix list problem
zcat ${SB_PATCHDIR}/numeric-24.2-arrayobject.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix skips of acosh, asinh
zcat ${SB_PATCHDIR}/numeric-24.2-umath.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix eigenvalue hang
zcat ${SB_PATCHDIR}/numeric-24.2-eigen.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix a bug in the test
zcat ${SB_PATCHDIR}/numeric-24.2-test.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix only for python-2.5
zcat ${SB_PATCHDIR}/numeric-24.2-python25.patch.gz | patch -p1 -E --backup --verbose || exit 1
# fix for dotblas from uncommited cvs
zcat ${SB_PATCHDIR}/numeric-24.2-dotblas.patch.gz | patch -p1 -E --backup --verbose || exit 1
