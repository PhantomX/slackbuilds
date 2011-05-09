
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=646220
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/dconf-editor-crash.patch

set +e +o pipefail
