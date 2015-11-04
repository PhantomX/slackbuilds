
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
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/tstclnt-ssl2-off-by-default.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/skip_stress_TLS_RC4_128_with_MD5.patch
# Upstream: https://bugzilla.mozilla.org/show_bug.cgi?id=923089
# Upstream: https://bugzilla.mozilla.org/show_bug.cgi?id=1009429
# See https://hg.mozilla.org/projects/nss/raw-rev/dc7bb2f8cc50
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ocsp_stapling_sslauth_sni_tests_client_side_fixes.patch
# Upstream: https://bugzilla.mozilla.org/show_bug.cgi?id=1205688
patch -p1 -E --backup --verbose -d nss -i ${SB_PATCHDIR}/rhbz1185708-enable-ecc-ciphers-by-default.patch
# Local patch for TLS_ECDHE_{ECDSA|RSA}_WITH_3DES_EDE_CBC_SHA ciphers
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/rhbz1185708-enable-ecc-3des-ciphers-by-default.patch

# Uncomment this if builds stops with -lz error
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-fix-zlib.patch

set +e +o pipefail
