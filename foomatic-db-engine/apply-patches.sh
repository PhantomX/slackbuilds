
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Use libdir.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libdir.patch
# Handle non-UTF-8 encodings in imported PPD files.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/foomatic-bad-utf8.patch

set +e +o pipefail
