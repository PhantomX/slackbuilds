  
SB_PATCHDIR=${CWD}/patches

# Patch ini files:
zcat ${SB_PATCHDIR}/${NAME}.ini.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1
zcat ${SB_PATCHDIR}/${NAME}.recommended.ini.diff.gz | patch -p1 --verbose --backup --suffix=.orig || exit 1

# Build fixes
#zcat ${SB_PATCHDIR}/${NAME}-5.2.9-gnusrc.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.2.8-install.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.2.4-norpath.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.2.8-phpize64.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.2.0-includedir.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.2.4-embed.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.2.8-recode.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fixes for extension modules
zcat ${SB_PATCHDIR}/${NAME}-4.3.11-shutdown.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.2.3-macropen.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Functional changes
zcat ${SB_PATCHDIR}/${NAME}-5.0.4-dlopen.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.2.4-easter.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.2.6-systzdata.patch.gz | patch -p1 -E --backup --verbose || exit 1

# Fixes for tests
zcat ${SB_PATCHDIR}/${NAME}-5.2.7-tests-dashn.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/${NAME}-5.0.4-tests-wddx.patch.gz | patch -p1 -E --backup --verbose || exit 1
