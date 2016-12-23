
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.2-getcwd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.0-newlines.patch
# Assume we don't have clock_gettime in configure, so that
# make is not linked against -lpthread (and thus does not
# limit stack to 2MB).
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.0-noclock_gettime.patch
# BZs #142691, #17374
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.2-j8k.patch
# Upstream: https://savannah.gnu.org/bugs/?30748
# The default value of .SHELL_FLAGS is -c.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.0-weird-shell.patch

set +e +o pipefail
