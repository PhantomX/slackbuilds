
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Use .so.${SSLSOVER}, not .so.${VERSION}:
sed -e "s|_SB_SOVER_|${SSLSOVER}|g" ${SB_PATCHDIR}/openssl.soname.diff \
  | patch -p1 --backup --verbose --suffix=.orig

# Build changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta3-defaults.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta5-enginesdir.patch
zcat ${SB_PATCHDIR}/openssl-0.9.8a-no-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8b-test-use-localhost.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-timezone.patch

# Bug fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta4-default-paths.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-0.9.8j-bad-mime.patch

# Functionality changes
zcat ${SB_PATCHDIR}/openssl-0.9.6-x509.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8j-version-add-engines.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta5-cipher-change.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta5-ipv6-apps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-0.9.8j-env-nozlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta4-dtls1-abi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta4-aesni.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-name-hash.patch

# Upstream

set +e +o pipefail
