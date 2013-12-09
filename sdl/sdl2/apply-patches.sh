
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Debian
# http://bugzilla.libsdl.org/show_bug.cgi?id=1460
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix_joystick_misc_axes.diff

set +e +o pipefail
