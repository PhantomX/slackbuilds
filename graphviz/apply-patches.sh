
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix SIGSEGVs on testsuite (#645703).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.26.0-testsuite-sigsegv-fix.patch
# Testsuite now do diff check also in case of err output (#645703).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.26.0-rtest-errout-fix.patch
#patch -p0 -E --backup -z .fixphp --verbose -i ${SB_PATCHDIR}/${NAME}-fix-php.patch
# Lua 5.2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.30.1-lua-5.2.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
