
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Fix CVE-2014-3230, bug #1094442,
# proposed in https://github.com/libwww-perl/lwp-protocol-https/pull/14
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/LWP-Protocol-https-6.06-Debian-746576-don-t-disale-verification-if-only-host.patch
# Fix CVE-2014-3230, bug #1094442,
# proposed in https://github.com/libwww-perl/lwp-protocol-https/pull/14
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/LWP-Protocol-https-6.06-Debian-746576-fix-test-make-it-workable-for-Crypt-SS.patch

set +e +o pipefail
