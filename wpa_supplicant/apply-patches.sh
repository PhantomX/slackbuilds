
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
# recover from streams of driver disconnect messages (iwl3945)
#patch -p1 -E --backup --verbose -z .disconnect-spam -i ${SB_PATCHDIR}/${NAME}-squelch-driver-disconnect-spam.patch
# allow more private key encryption algorithms
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-openssl-more-algs.patch

set +e +o pipefail
