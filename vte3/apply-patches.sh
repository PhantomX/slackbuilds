
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/honey-I-shrank-the-terminal.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=663779
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/vte-alt-meta-confusion.patch

set +e +o pipefail
