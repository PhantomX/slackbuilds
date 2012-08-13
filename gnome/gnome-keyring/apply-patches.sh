
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix improper passphrase caching.
# http://www.openwall.com/lists/oss-security/2012/08/09/2
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gpg-agent-Hook-up-the-TTL-cache-option.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/schema-Update-description-for-gpg-cache-method.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/secret-store-Mark-a-secret-item-as-used-when-acces.patch

set +e +o pipefail
