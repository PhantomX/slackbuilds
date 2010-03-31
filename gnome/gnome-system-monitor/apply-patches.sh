
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# send upstream: http://bugzilla.gnome.org/show_bug.cgi?id=491462
zcat ${SB_PATCHDIR}/${NAME}-2.25.91-polkit.patch.gz | patch -p1 -E --backup --verbose

# sent upstream: http://bugzilla.gnome.org/show_bug.cgi?id=421912
zcat ${SB_PATCHDIR}/session.patch.gz | patch -p1 -E --backup --verbose

# https://bugzilla.redhat.com/show_bug.cgi?id=495730
zcat ${SB_PATCHDIR}/polkit1.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=592747
zcat ${SB_PATCHDIR}/buttons.patch.gz | patch -p1 -E --backup --verbose

# http://bugzilla.gnome.org/show_bug.cgi?id=592758
zcat ${SB_PATCHDIR}/memmapsdialog.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
