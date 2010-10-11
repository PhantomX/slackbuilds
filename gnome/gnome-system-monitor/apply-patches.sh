
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# sent upstream: http://bugzilla.gnome.org/show_bug.cgi?id=491462
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/polkit.patch
# sent upstream: http://bugzilla.gnome.org/show_bug.cgi?id=421912
zcat ${SB_PATCHDIR}/session.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=592758
zcat ${SB_PATCHDIR}/memmapsdialog.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
