
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Make mkmf verbose by default
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ruby-1.9.3-mkmf-verbose.patch
# Readline 6.3
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-undeclared-identifier-error-by-using-the-actual-.patch

set +e +o pipefail
