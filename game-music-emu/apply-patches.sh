
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup -z .libsuffix --verbose -i ${SB_PATCHDIR}/${NAME}-0.5.5-libsuffix.patch

set +e +o pipefail
