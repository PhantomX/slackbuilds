
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# upstream commit e32fe30d0cf7c1f7045ac0bd29322e7fb4feb5c8
patch -p1 -E --backup --verbose -R -i ${SB_PATCHDIR}/curl-7.20.0-e32fe30.patch
# patch making libcurl multilib ready
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/curl-7.20.0-multilib.patch
# force -lrt when linking the curl tool and test-cases
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/curl-7.20.0-lrt.patch
# prevent configure script from discarding -g in CFLAGS
zcat ${SB_PATCHDIR}/curl-7.19.4-debug.patch.gz | patch -p1 -E --backup --verbose || exit 1
# suppress occasional failure of curl test-suite on s390; caused more likely
# by the test-suite infrastructure than (lib)curl itself
# http://curl.haxx.se/mail/lib-2009-12/0031.html
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/curl-7.20.1-test-delay.patch
# use localhost6 instead of ip6-localhost in the curl test-suite
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/curl-7.19.7-localhost6.patch
# exclude test1112 from the test suite (#565305)
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/curl-7.20.0-disable-test1112.patch

set +e +o pipefail
