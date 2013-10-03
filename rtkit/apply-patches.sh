
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-SECURITY-Pass-uid-of-caller-to-polkit.patch
### Arch
if [ "${SB_SYSTEMD}" = "YES" ] ;then
  patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libsystemd.patch
  rm -f sd-daemon.h
fi
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/systemd205.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
