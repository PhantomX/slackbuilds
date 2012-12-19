
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# nss-util

# nss-softokn

# nss
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/add-relro-linker-option.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/renegotiate-transitional.patch
zcat ${SB_PATCHDIR}/nss-enable-pem.patch.gz | patch -p0 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-539183.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-646045.patch
# Prevent users from trying to enable ssl pkcs11 bypass
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-ssl-enforce-no-pkcs11-bypass.path
# TODO: Remove this patch when the ocsp test are fixed
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nss-3.14.0.0-disble-ocsp-test.patch

# Uncomment this if builds stops with -lz error
#zcat ${SB_PATCHDIR}/nss-fix-zlib.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
