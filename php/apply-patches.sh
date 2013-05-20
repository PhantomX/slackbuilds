
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

# Patch ini files:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php.ini-development.diff
patch -p1 -E --backup --verbose php.ini-production -i ${SB_PATCHDIR}/php.ini-development.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-fpm.conf.diff

# Build fixes
zcat ${SB_PATCHDIR}/php-5.2.0-includedir.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.2.4-embed.patch
zcat ${SB_PATCHDIR}/php-5.3.0-recode.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.7-libdb.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/004_all_strict_aliasing.patch

# Fixes for extension modules
# https://bugs.php.net/63171 no odbc call during timeout
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.7-odbctimer.patch

# Functional changes
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.0-dlopen.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.0-easter.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.3.1-systzdata-v9.patch
# See http://bugs.php.net/53436
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.0-phpize.patch
# Use system libzip instead of bundled one
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.15-system-libzip.patch
# Use -lldap_r for OpenLDAP
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.8-ldap_r.patch
# Make php_config.h constant across builds
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.9-fixheader.patch
# drop "Configure command" from phpinfo output
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/php-5.4.9-phpinfo.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
