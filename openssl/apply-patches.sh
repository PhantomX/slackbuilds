
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# Use .so.0, not .so.0.9.8:
zcat ${SB_PATCHDIR}/openssl.soname.diff.gz | patch -p1 --backup --verbose --suffix=.orig
zcat ${SB_PATCHDIR}/openssl.optsx86.diff.gz | patch -p1 --backup --verbose --suffix=.orig

# Build changes
#zcat ${SB_PATCHDIR}/openssl-0.9.8j-redhat.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8a-defaults.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/openssl-0.9.8a-link-krb5.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/openssl-0.9.8j-soversion.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/openssl-0.9.8j-enginesdir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8a-no-rpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8b-test-use-localhost.patch.gz | patch -p1 -E --backup --verbose
#zcat ${SB_PATCHDIR}/openssl-0.9.8j-shlib-version.patch.gz | patch -p1 -E --backup --verbose

# Bug fixes
zcat ${SB_PATCHDIR}/openssl-0.9.8k-x509-name-cmp.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8g-default-paths.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8g-no-extssl.patch.gz | patch -p1 -E --backup --verbose

# Functionality changes
#zcat ${SB_PATCHDIR}/openssl-0.9.8g-ia64.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.6-x509.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8j-version-add-engines.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8m-reuse-cipher-change.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/openssl-0.9.8g-ipv6-apps.patch.gz | patch -p1 -E --backup --verbose

# Upstream


set +e +o pipefail
