
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .shared --verbose -i ${SB_PATCHDIR}/rtmpdump-shared.patch
patch -p0 -E --backup -z .libs --verbose -i ${SB_PATCHDIR}/rtmpdump-libs.patch

set +e +o pipefail
