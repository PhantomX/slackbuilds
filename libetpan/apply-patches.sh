
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-multiarch.patch
[ "${SB_GNUTLS}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-cryptopolicy.patch
patch -p0 -E --backup --verbose -z .gnutls -i ${SB_PATCHDIR}/${NAME}-gnutls.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/182.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/3310162627af01b25dc70a87374436fa0d7b1306.patch

set +e +o pipefail
