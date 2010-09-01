
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Apply the patches to the newer NSS tree
zcat ${SB_PATCHDIR}/nss-no-rpath.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup -z .prelink --verbose -i ${SB_PATCHDIR}/nss-softokn-3.12.4-prelink.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-softokn-3.12.4-fips-fix.patch
zcat ${SB_PATCHDIR}/renegotiate-transitional.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/nss-enable-pem.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/533125-ammend.patch.gz | patch -p0 -E --backup --verbose
zcat ${SB_PATCHDIR}/nss-538226.patch.gz | patch -p0 -E --backup --verbose
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/nss-sysinit-userdb-first.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-support-for-PKCS-8-encoded-private-keys.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Do-not-define-SEC_SkipTemplate.patch
# Uncomment this if builds stops with -lz error
#zcat ${SB_PATCHDIR}/nss-fix-zlib.patch.gz | patch -p0 -E --backup --verbose

set +e +o pipefail
