
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup -z .ldflags --verbose -i ${SB_PATCHDIR}/${NAME}-1.4.03-ldflags.patch

set +e +o pipefail
