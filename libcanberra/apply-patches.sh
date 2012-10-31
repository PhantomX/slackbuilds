
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
[ "${SB_ALSA}" = "YES" ] &&  patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.30-alsa-default.patch

set +e +o pipefail
