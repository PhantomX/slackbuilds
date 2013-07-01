
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://bugzilla.gnome.org/show_bug.cgi?id=593030
zcat ${SB_PATCHDIR}/gtk-engines-2.18.2-change-bullet.patch.gz | patch -p1 -E --backup --verbose
zcat ${SB_PATCHDIR}/tooltips.patch.gz | patch -p1 -E --backup --verbose

set +e +o pipefail
