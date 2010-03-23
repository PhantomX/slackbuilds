
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p0 -E --backup -z .kde --verbose -i ${SB_PATCHDIR}/${NAME}-8.0.2-kde4.patch

set +e +o pipefail
