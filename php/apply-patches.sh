  
SB_PATCHDIR=${CWD}/patches

# Patch ini files:
zcat ${SB_PATCHDIR}/php.ini.diff.gz | sed \
  -e "/extension_dir/s|/lib/|/lib${LIBDIRSUFFIX}|g" \
  | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/php.development.ini.diff.gz | \
  -e "/extension_dir/s|/lib/|/lib${LIBDIRSUFFIX}|g" \
  | patch -p1 --verbose --backup --suffix=.orig || exit 1

# Build fixes
#zcat ${SB_PATCHDIR}/php-5.3.1-gnusrc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.3.0-install.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.2.4-norpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.3.0-phpize64.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.2.0-includedir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.2.4-embed.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.3.0-recode.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.3.1-aconf26x.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fixes for extension modules
zcat ${SB_PATCHDIR}/php-4.3.11-shutdown.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.2.3-macropen.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Functional changes
zcat ${SB_PATCHDIR}/php-5.0.4-dlopen.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.3.0-easter.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/php-5.3.1-systzdata-v7.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fixes for tests
zcat ${SB_PATCHDIR}/php-5.0.4-tests-wddx.patch.gz | patch -p1 -E --backup --verbose || exit 1
