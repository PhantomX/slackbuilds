
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8-doc-build.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-eds-build-fix.patch
patch -p0 -E --backup -z .poppler --verbose -i ${SB_PATCHDIR}/${NAME}-poppler-0.16.patch

set +e +o pipefail
