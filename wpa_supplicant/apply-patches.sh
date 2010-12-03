
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .assoc-timeout --verbose -i ${SB_PATCHDIR}/${NAME}-assoc-timeout.patch
zcat ${SB_PATCHDIR}/wpa_supplicant-0.5.7-qmake-location.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/wpa_supplicant-0.5.7-flush-debug-output.patch.gz | patch -p1 -E --backup --verbose
patch -p1 -E --backup -z .scan-results-msg --verbose -i ${SB_PATCHDIR}/wpa_supplicant-0.7.3-quiet-scan-results-message.patch
#zcat ${SB_PATCHDIR}/wpa_supplicant-0.6.8-ap-stability.patch.gz | patch -p1 -E --backup -z .ap-stability --verbose
zcat ${SB_PATCHDIR}/wpa_supplicant-0.6.8-openssl-init.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
