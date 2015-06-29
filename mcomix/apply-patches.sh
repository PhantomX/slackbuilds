
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mcomix-0.92-fedora-rpmbuild-gtk.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/mcomix-0.98-gettext-system-install.patch

set +e +o pipefail
