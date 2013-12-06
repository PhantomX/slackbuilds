
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
### Fedora
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.22-dsofix.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.20.2-manpage.patch
# from https://bugzilla.gnome.org/show_bug.cgi?id=636890
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.22-gtk-2.22.1.patch

set +e +o pipefail
