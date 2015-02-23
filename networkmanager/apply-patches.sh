
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/02-dbus_access_network_manager.patch

### Arch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/disable_set_hostname.patch

### Fedora
# https://bugzilla.redhat.com/show_bug.cgi?id=1162636
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/NetworkManager-1.0.0-bridge_resume.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
