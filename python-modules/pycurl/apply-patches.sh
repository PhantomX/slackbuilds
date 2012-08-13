
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/python-pycurl-no-static-libs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/python-pycurl-fix-do_curl_reset-refcount.patch

set +e +o pipefail
