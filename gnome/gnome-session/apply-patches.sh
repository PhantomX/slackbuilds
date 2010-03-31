
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# https://bugzilla.gnome.org/show_bug.cgi?id=597030
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-ability-to-perform-actions-after-a-period-of-idl.patch

# https://bugzilla.gnome.org/show_bug.cgi?id=607094
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nag-root-user.patch

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/gnome-session-libs.patch

set +e +o pipefail
