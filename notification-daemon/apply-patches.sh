
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Arch
# Avoid crashes for boolean hints
# https://bugzilla.gnome.org/show_bug.cgi?id=665166
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-boolean-hint.patch
# Fix GSource usage with recent GLib
# https://bugzilla.gnome.org/show_bug.cgi?id=728157
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-gsource-usage.patch
# Fix positioning notifications with long text
# https://bugzilla.gnome.org/show_bug.cgi?id=687724
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/fix-position.patch

set +e +o pipefail
