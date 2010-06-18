
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# upstream commit e32fe30d0cf7c1f7045ac0bd29322e7fb4feb5c8
patch -p1 -E --backup --verbose -R -i ${SB_PATCHDIR}/curl-7.20.0-e32fe30.patch
# patch making libcurl multilib ready
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/curl-7.20.0-multilib.patch
# force -lrt when linking the curl tool and test-cases
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/curl-7.20.0-lrt.patch
# prevent configure script from discarding -g in CFLAGS
zcat ${SB_PATCHDIR}/curl-7.19.4-debug.patch.gz | patch -p1 -E --backup --verbose || exit 1
# use localhost6 instead of ip6-localhost in the curl test-suite
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/curl-7.19.7-localhost6.patch

set +e +o pipefail
