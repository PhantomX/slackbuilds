
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/pygtk-nodisplay-exception.patch.gz | patch -p1 -E --backup --verbose
# https://bugzilla.gnome.org/show_bug.cgi?id=624834
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Remove-deprecated-sink-functions.patch

set +e +o pipefail
