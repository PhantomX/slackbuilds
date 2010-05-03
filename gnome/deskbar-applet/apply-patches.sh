
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.30.0-py_sitearch.patch

set +e +o pipefail
