
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Build changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-defaults.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-enginesdir.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-no-rpath.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-test-use-localhost.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-timezone.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1c-perlfind.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1c-aliasing.patch

# Bug fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2c-default-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-issuer-hash.patch

# Functionality changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-x509.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-version-add-engines.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-ipv6-apps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-env-zlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-dtls1-abi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-apps-dgst.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-xmpp-starttls.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-chil-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-pkgconfig-krb5.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-weak-ciphers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-enc-fail.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-system-cipherlist.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-disable-sslv2v3.patch
# Backported fixes including security fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-padlock64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2c-trusted-first-doc.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.2a-cc-reqs.patch

# Use .so.${SSLSOVER}, not .so.${VERSION}:
sed -e "s|_SB_SOVER_|${SSLSOVER}|g" ${SB_PATCHDIR}/openssl.soname.diff \
  | patch -p1 --backup --verbose --suffix=.orig

# Upstream

set +e +o pipefail
