
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .assoc-timeout --verbose -i ${SB_PATCHDIR}/${NAME}-assoc-timeout.patch

# ensures that debug output gets flushed immediately to help diagnose driver
# bugs, not suitable for upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-flush-debug-output.patch
# disto specific customization for log paths, not suitable for upstream
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-dbus-service-file-args.patch
# quiet an annoying and frequent syslog message
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-quiet-scan-results-message.patch
# allow more private key encryption algorithms
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-openssl-more-algs.patch
# Less aggressive roaming; signal strength is wildly variable
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rh837402-less-aggressive-roaming.patch
# CVE-2015-1863, backport from upstream master, will be in 2.5
# http://w1.fi/cgit/hostap/commit/?id=9ed4eee345f85e3025c33c6e20aa25696e341ccd
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-P2P-Validate-SSID-element-length-before-copying-it-C.patch

set +e +o pipefail
