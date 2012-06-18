
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Patch ini files:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php.ini-development.diff
patch -p1 -E --backup --verbose php.ini-production -i ${SB_PATCHDIR}/php.ini-development.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-fpm.conf.diff

# Build fixes
zcat ${SB_PATCHDIR}/php-5.2.0-includedir.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.2.4-embed.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/php-5.3.0-recode.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/004_all_strict_aliasing.patch

# Fixes for extension modules

# Functional changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.0-dlopen.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.0-easter.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.3.1-systzdata-v8.patch
# See http://bugs.php.net/53436
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.0-phpize.patch
# Use system libzip instead of bundled one
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.1-system-libzip.patch

# Fixes for tests

set +e +o pipefail
