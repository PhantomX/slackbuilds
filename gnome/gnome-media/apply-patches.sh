
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=519438
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Add-speaker-testing-UI.patch

set +e +o pipefail
