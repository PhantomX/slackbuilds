
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
( cd clamd-*
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-clam-socket.patch
)
( cd geolocation_plugin-*
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-geolocation-champlain-0.9.patch
)
( cd notification_plugin-*
  patch -p2 -E --backup --verbose -i ${SB_PATCHDIR}/claws-mail-extra-plugins-3.7.9-libnotify07.patch
)

set +e +o pipefail
