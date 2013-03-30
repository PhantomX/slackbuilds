
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ignore-more-pep8-errors.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/pygobject-3.3.4-known-failures.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/test-list-marshalling.patch

set +e +o pipefail
