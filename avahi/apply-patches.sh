
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
# Disable -Werror and remove G*_DISABLE_DEPRECATED definitions
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/avahi-0.6.31-no-deprecations.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=1105647
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Disable-publish-workstation-and-publish-hinfo-by-def.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-netlink-check-that-the-origin-of-the-rtnetlink-messa.patch

# Set to YES if autogen is needed
SB_AUTOGEN=YES

set +e +o pipefail
