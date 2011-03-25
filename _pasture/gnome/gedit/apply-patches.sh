
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# http://bugzilla.gnome.org/show_bug.cgi?id=569214
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gedit-2.25.5-fix-python-path.patch
# http://bugzilla.gnome.org/show_bug.cgi?id=587053
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/print-to-file.patch

set +e +o pipefail
