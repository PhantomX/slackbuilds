
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/libsndfile-1.0.17-regtests-need-sqlite.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/libsndfile-1.0.18-less_strict_tests.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libsndfile-1.0.25-system-gsm.patch

set +e +o pipefail
