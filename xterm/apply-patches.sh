
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/${NAME}-242-resources.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-255-man-page_paths.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
