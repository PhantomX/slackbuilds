
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Patch to remove use of private llvm headers
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Replace-uses-of-MIUtilParse-CRegexParser-with-llvm-R.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Remove-MIUtilParse-no-longer-used.patch

set +e +o pipefail
