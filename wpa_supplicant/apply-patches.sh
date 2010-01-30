  
SB_PATCHDIR=${CWD}/patches

zcat ${SB_PATCHDIR}/wpa_supplicant-assoc-timeout.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/wpa_supplicant-0.5.7-qmake-location.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/wpa_supplicant-0.5.7-flush-debug-output.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/wpa_supplicant-0.5.10-dbus-service-file.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/wpa_supplicant-0.6.10-quiet-scan-results-message.patch.gz | patch -p1 -E --backup -z .scan-results-msg --verbose || exit 1
#zcat ${SB_PATCHDIR}/wpa_supplicant-0.6.8-handle-driver-disconnect-spam.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/wpa_supplicant-0.6.8-ap-stability.patch.gz | patch -p1 -E --backup --verbose || exit 1
#zcat ${SB_PATCHDIR}/wpa_supplicant-0.6.9-scan-faster.patch.gz | patch -p1 -E --backup --verbose || exit 1
zcat ${SB_PATCHDIR}/wpa_supplicant-0.6.8-openssl-init.patch.gz | patch -p1 -E --backup --verbose || exit 1
