
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch

## Distro specific patches ##

# Distro artwork, start on vt1
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-config.patch

# Pam
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/lxdm-0.4.1-pam.patch

set +e +o pipefail
