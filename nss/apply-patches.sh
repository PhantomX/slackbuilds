
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# nss-util

# nss-softokn
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-softokn-add_encrypt_derive.patch

# nss
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/add-relro-linker-option.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/renegotiate-transitional.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-enable-pem.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-539183.patch
# TODO: Remove this patch when the ocsp test are fixed
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-3.14.0.0-disble-ocsp-test.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/iquote.patch
patch -p1 -E --backup --verbose -d nss -i ${SB_PATCHDIR}/disableSSL2libssl.patch
patch -p1 -E --backup --verbose -d nss -i ${SB_PATCHDIR}/disableSSL2tests.patch

# Uncomment this if builds stops with -lz error
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-fix-zlib.patch

set +e +o pipefail
