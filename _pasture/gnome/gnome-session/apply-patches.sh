
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=597030
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-ability-to-perform-actions-after-a-period-of-idl.patch

# https://bugzilla.gnome.org/show_bug.cgi?id=607094
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/nag-root-user.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-cflags.patch
patch -p0 -E --backup -z .libnotify --verbose -i ${SB_PATCHDIR}/${NAME}-2.32.1-libnotify07.patch

set +e +o pipefail
