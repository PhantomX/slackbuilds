
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

# Functionality changes
zcat ${SB_PATCHDIR}/openssl-0.9.6-x509.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8j-version-add-engines.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1h-ipv6-apps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-0.9.8j-env-nozlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1k-dtls1-abi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0d-apps-dgst.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0d-xmpp-starttls.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0e-chil-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1c-dh-1024.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-weak-ciphers.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-enc-fail.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1h-system-cipherlist.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1h-disable-sslv2v3.patch
# Backported fixes including security fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1k-padlock64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1i-manfix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1k-trusted-first.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1k-ephemeral-key-size.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-cc-reqs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1k-cve-2015-0209.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-cve-2015-0286.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-cve-2015-0287.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-cve-2015-0288.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1k-cve-2015-0289.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1e-cve-2015-0293.patch

# Use .so.${SSLSOVER}, not .so.${VERSION}:
sed -e "s|_SB_SOVER_|${SSLSOVER}|g" ${SB_PATCHDIR}/openssl.soname.diff \
  | patch -p1 --backup --verbose --suffix=.orig

# Upstream

set +e +o pipefail
