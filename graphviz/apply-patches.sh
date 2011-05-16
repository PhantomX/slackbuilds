
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix SIGSEGVs on testsuite (#645703).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.26.0-testsuite-sigsegv-fix.patch
# Testsuite now do diff check also in case of err output (#645703).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.26.0-rtest-errout-fix.patch

set +e +o pipefail
