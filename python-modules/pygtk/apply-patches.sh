
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
zcat ${SB_PATCHDIR}/pygtk-nodisplay-exception.patch.gz | patch -p1 -E --backup --verbose
# https://bugzilla.gnome.org/show_bug.cgi?id=624834
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Remove-deprecated-sink-functions.patch
# http://git.gnome.org/browse/pygtk/commit/?id=a9e24426aae96e5968b95ef76aacf41d3153ddf7
# RH bug: https://bugzilla.redhat.com/show_bug.cgi?id=618944
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-pygtk-2.0.pc-Should-require-gtk-2.0.patch

set +e +o pipefail
