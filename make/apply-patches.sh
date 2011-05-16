
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

set +e +o pipefail
