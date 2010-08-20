
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=596615
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/rb-no-HEAD-for-podcasts.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=613606
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Don-t-load-AFC-devices-using-the-MTP-plugin.patch
# From Gentoo
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12.8-namespace-conflict.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.12-python-initialization.patch

set +e +o pipefail
