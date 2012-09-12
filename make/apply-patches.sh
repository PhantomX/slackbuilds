
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-noclock_gettime.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-j8k.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-getcwd.patch
patch -p1 -E --backup -z .err-rep --verbose -i ${SB_PATCHDIR}/make-3.82-err-reporting.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-weird-shell.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-newlines.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-jobserver.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-bugfixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-sort-blank.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-copy-on-expand.patch
# Upstream: https://savannah.gnu.org/bugs/?33873
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-parallel-remake.patch
# http://savannah.gnu.org/bugs/?34335
patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-warn_undefined_function.patch
# http://lists.gnu.org/archive/html/bug-make/2011-06/msg00032.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-trace.patch
# http://lists.gnu.org/archive/html/bug-make/2011-04/msg00002.html
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-expensive_glob.patch
# Upstream: https://savannah.gnu.org/bugs/?30653
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-dont-prune-intermediate.patch

set +e +o pipefail
