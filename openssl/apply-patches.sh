
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Build changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta3-defaults.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta5-enginesdir.patch
zcat ${SB_PATCHDIR}/openssl-0.9.8a-no-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8b-test-use-localhost.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-timezone.patch

# Bug fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0-beta4-default-paths.patch

# Functionality changes
zcat ${SB_PATCHDIR}/openssl-0.9.6-x509.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8j-version-add-engines.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-beta2-ssl-op-all.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-beta2-ipv6-apps.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-0.9.8j-env-nozlib.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-beta2-dtls1-abi.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-version.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0d-apps-dgst.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0d-xmpp-starttls.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.0e-chil-fixes.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-beta2-padlock64.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/openssl-1.0.1-backport.patch

# Use .so.${SSLSOVER}, not .so.${VERSION}:
sed -e "s|_SB_SOVER_|${SSLSOVER}|g" ${SB_PATCHDIR}/openssl.soname.diff \
  | patch -p1 --backup --verbose --suffix=.orig

# Upstream

set +e +o pipefail
