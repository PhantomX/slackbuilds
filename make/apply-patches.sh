
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-3.80-j8k.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/make-3.82-getcwd.patch
patch -p1 -E --backup -z .err-rep --verbose -i ${SB_PATCHDIR}/${NAME}-3.82-err-reporting.patch

set +e +o pipefail
