
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/${NAME}-242-resources.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .man-page_paths --verbose -i ${SB_PATCHDIR}/${NAME}-man-paths.patch

set +e +o pipefail
