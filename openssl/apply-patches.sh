  
SB_PATCHDIR=${CWD}/patches

# Use .so.0, not .so.0.9.8:
zcat ${SB_PATCHDIR}/${NAME}.soname.diff.gz | patch -p1 --backup --verbose --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}.optsx86.diff.gz | patch -p1 --backup --verbose --suffix=.orig || exit 1

# Build changes
#zcat ${SB_PATCHDIR}/${NAME}-0.9.8g-redhat.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.8a-defaults.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-0.9.8a-link-krb5.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-0.9.8g-soversion.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-0.9.8a-enginesdir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.8a-no-rpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.8b-test-use-localhost.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/${NAME}-0.9.8g-shlib-version.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Bug fixes
zcat ${SB_PATCHDIR}/${NAME}-0.9.8b-aliasing-bug.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.8b-x509-name-cmp.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.8g-default-paths.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.8g-no-extssl.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Functionality changes
#zcat ${SB_PATCHDIR}/${NAME}-0.9.7-beta6-ia64.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.6-x509.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.7-beta5-version-add-engines.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.8a-reuse-cipher-change.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-0.9.8g-ipv6-apps.patch.gz | patch -p1 -E --backup --verbose || exit 1
