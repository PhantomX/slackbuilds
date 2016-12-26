
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Debian
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-trashing-on-overlayfs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-timer-test-use-volatile-for-locals.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/03_disble_glib_compile_schemas_warning.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/04_homedir_env.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/Do-not-attempt-to-autolaunch-a-session-dbus-daemon-w.patch

# Set to YES if autogen is needed
SB_AUTOGEN=NO

set +e +o pipefail
