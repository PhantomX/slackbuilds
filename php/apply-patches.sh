
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Patch ini files:
zcat ${SB_PATCHDIR}/php.ini.diff.gz | sed \
  -e "/extension_dir/s|/lib/|/lib${LIBDIRSUFFIX}|g" \
  | patch -p1 --verbose --backup --suffix=.orig
zcat ${SB_PATCHDIR}/php.development.ini.diff.gz | sed \
  -e "/extension_dir/s|/lib/|/lib${LIBDIRSUFFIX}|g" \
  | patch -p1 --verbose --backup --suffix=.orig

# Build fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.3.2-gnusrc.patch
zcat ${SB_PATCHDIR}/php-5.3.0-install.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.2.4-norpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.0-phpize64.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.2.0-includedir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.2.4-embed.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.0-recode.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.2-aconf26x.patch.gz | patch -p1 -E --backup --verbose
# http://bugs.php.net/50578
zcat ${SB_PATCHDIR}/php-5.3.2-phar.patch.gz | patch -p1 -E --backup --verbose
patch -p4 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.3.2-gc.patch

# Fixes for extension modules
zcat ${SB_PATCHDIR}/php-4.3.11-shutdown.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.2.3-macropen.patch.gz | patch -p1 -E --backup --verbose

# Functional changes
zcat ${SB_PATCHDIR}/php-5.0.4-dlopen.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.0-easter.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.1-systzdata-v7.patch.gz | patch -p1 -E --backup --verbose

# Fixes for tests
zcat ${SB_PATCHDIR}/php-5.0.4-tests-wddx.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
