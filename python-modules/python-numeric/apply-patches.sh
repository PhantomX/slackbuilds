
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# fix list problem
zcat ${SB_PATCHDIR}/numeric-24.2-arrayobject.patch.gz | patch -p1 -E --backup --verbose
# fix skips of acosh, asinh
zcat ${SB_PATCHDIR}/numeric-24.2-umath.patch.gz | patch -p1 -E --backup --verbose
# fix eigenvalue hang
zcat ${SB_PATCHDIR}/numeric-24.2-eigen.patch.gz | patch -p1 -E --backup --verbose
# fix a bug in the test
zcat ${SB_PATCHDIR}/numeric-24.2-test.patch.gz | patch -p1 -E --backup --verbose
# fix only for python-2.5
zcat ${SB_PATCHDIR}/numeric-24.2-python25.patch.gz | patch -p1 -E --backup --verbose
# fix for dotblas from uncommited cvs
zcat ${SB_PATCHDIR}/numeric-24.2-dotblas.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
