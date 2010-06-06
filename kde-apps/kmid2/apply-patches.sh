
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# http://websvn.kde.org/?revision=1134129&view=revision
# Fix a crash in the ALSA backend due to reloadDeviceList (kde#240394)
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/kmid-2.3.0-kde\#240394.patch

set +e +o pipefail
