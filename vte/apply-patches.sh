
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Escape sequences can cause high CPU usage (CVE-2012-2738):
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vte.escape.cpu.usage.diff
# https://bugzilla.gnome.org/show_bug.cgi?id=663779
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vte-alt-meta-confusion.patch
# Python bindings bugfix
# https://bugzilla.redhat.com/show_bug.cgi?id=556200
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vte-python-bugfixes.patch

set +e +o pipefail
