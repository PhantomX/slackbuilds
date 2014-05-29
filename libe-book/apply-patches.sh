
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-libcss-et-al.-are-not-required-for-standard-build.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0002-HTML-based-formats-are-not-supported-yet.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-parse-zipped-FictionBook-2-files-again.patch

set +e +o pipefail
