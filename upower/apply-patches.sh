
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Upstream: don't crash with new polkits.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/upower-0.9.6-ensure-gerror-is-init.patch
# Don't return more or less than once from a dbus call
# and don't leak errors all over the place
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/upower-dbus-fixes.patch

set +e +o pipefail
