
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.0-noclock_gettime.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.0-j8k.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.0-getcwd.patch
patch -p1 -E --backup -z .err-rep --verbose -i ${SB_PATCHDIR}/make-4.0-err-reporting.patch
# Upstream: https://savannah.gnu.org/bugs/?30748
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.0-weird-shell.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-4.0-newlines.patch

set +e +o pipefail
