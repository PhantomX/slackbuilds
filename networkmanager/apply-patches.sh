
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nm-polkit-permissive.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-error.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/initialize-GError.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dont-fight-over-ipv6.patch

set +e +o pipefail
