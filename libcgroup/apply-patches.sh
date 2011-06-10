
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Remove Red Hat / LSB init-scriptisms:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libcgroup.init.diff
# Slackware does not use /etc/sysconfig:
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libcgroup.conf.diff
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libcgroup-0.36.2-systemd.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libcgroup-0.37.1-systemd.patch

set +e +o pipefail
