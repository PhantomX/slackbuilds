
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Build changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta3-defaults.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta5-enginesdir.patch
zcat ${SB_PATCHDIR}/openssl-0.9.8a-no-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8b-test-use-localhost.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-timezone.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1c-perlfind.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1c-aliasing.patch

# Bug fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1c-default-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1g_CVE-2010-5298.diff

# Functionality changes
zcat ${SB_PATCHDIR}/openssl-0.9.6-x509.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8j-version-add-engines.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0e-doc-noeof.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-beta2-ssl-op-all.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1c-ipv6-apps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-0.9.8j-env-nozlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-beta2-dtls1-abi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0d-apps-dgst.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0d-xmpp-starttls.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0e-chil-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1c-dh-1024.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-weak-ciphers.patch
# Backported fixes including security fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-beta2-padlock64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-manfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-trusted-first.patch

# Use .so.${SSLSOVER}, not .so.${VERSION}:
sed -e "s|_SB_SOVER_|${SSLSOVER}|g" ${SB_PATCHDIR}/openssl.soname.diff \
  | patch -p1 --backup --verbose --suffix=.orig

# Upstream

set +e +o pipefail
