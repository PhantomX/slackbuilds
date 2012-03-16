
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
[ "${SB_VV}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/port-to-farstream.patch

set +e +o pipefail
