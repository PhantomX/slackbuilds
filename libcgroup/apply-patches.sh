
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Remove Red Hat / LSB init-scriptisms:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libcgroup.init.diff
### Fedora
[ "${SB_SYSTEMD}" = "YES" ] && patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fedora-config.patch

set +e +o pipefail
