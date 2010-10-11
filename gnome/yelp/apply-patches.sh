
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://bugzilla.gnome.org/show_bug.cgi?id=319096
# zcat ${SB_PATCHDIR}/${NAME}-2.15.5-fedora-docs.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-2.13.2-add-mime-handling.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/${NAME}-use-pango.patch.gz | patch -p1 -E --backup --verbose
# http://bugzilla.gnome.org/show_bug.cgi?id=592762
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/ellipsis.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/libs.patch

set +e +o pipefail
