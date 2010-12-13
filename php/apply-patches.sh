
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Patch ini files:
sed -e "/extension_dir/s|/lib/|/lib${LIBDIRSUFFIX}/|g" \
  ${SB_PATCHDIR}/php.ini.diff \
  | patch -p1 --verbose --backup --suffix=.orig
sed -e "/extension_dir/s|/lib/|/lib${LIBDIRSUFFIX}/|g" \
  ${SB_PATCHDIR}/php.development.ini.diff \
  | patch -p1 --verbose --backup --suffix=.orig

# Build fixes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.3.4-gnusrc.patch
zcat ${SB_PATCHDIR}/php-5.3.0-install.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.2.4-norpath.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.0-phpize64.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.2.0-includedir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.2.4-embed.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.0-recode.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.3.4-aconf26x.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/004_all_strict_aliasing.patch

# Fixes for extension modules
zcat ${SB_PATCHDIR}/php-4.3.11-shutdown.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.3.3-macropen.patch

# Functional changes
zcat ${SB_PATCHDIR}/php-5.0.4-dlopen.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.0-easter.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.1-systzdata-v7.patch.gz | patch -p1 -E --backup --verbose
# See http://bugs.php.net/53436
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.3.4-phpize.patch

# Security patch from upstream SVN
# http://svn.php.net/viewvc?view=revision&revision=306154
patch -p4 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.3.4-cve.patch

# Fixes for tests
zcat ${SB_PATCHDIR}/php-5.0.4-tests-wddx.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
