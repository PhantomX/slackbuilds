
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Avoid insecure sprintf(), use a system path for lempar.c, patch from Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sqlite-3.6.23-lemon-system-template.patch
# Shut up stupid tests depending on system settings of allowed open fd's
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sqlite-3.7.7.1-stupid-openfiles-test.patch
# Shut up pagecache overflow test whose expected result depends on compile
# options and whatnot. Dunno why this started failing in 3.7.10 but
# doesn't seem particularly critical...
#patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sqlite-3.7.10-pagecache-overflow-test.patch
# sqlite >= 3.7.10 is buggy if malloc_usable_size() is detected, disable it:
# https://bugzilla.redhat.com/show_bug.cgi?id=801981
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=665363
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sqlite-3.12.2-no-malloc-usable-size.patch
# Temporary workaround for failed percentile test, see patch for details
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/sqlite-3.8.0-percentile-test.patch

set +e +o pipefail
