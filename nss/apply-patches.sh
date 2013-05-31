
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# nss-util
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/hasht-dont-include-prtypes.patch

# nss-softokn

# nss
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/add-relro-linker-option.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/renegotiate-transitional.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-enable-pem.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-539183.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-646045.patch
# Prevent users from trying to enable ssl pkcs11 bypass
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-ssl-enforce-no-pkcs11-bypass.path
# TODO: Remove this patch when the ocsp test are fixed
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-3.14.0.0-disble-ocsp-test.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-sync-up-with-upstream-softokn-changes.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/Bug-896651-pem-dont-trash-keys-on-failed-login.patch

# Uncomment this if builds stops with -lz error
#patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-fix-zlib.patch

set +e +o pipefail
