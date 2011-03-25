
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.gnome.org/show_bug.cgi?id=597435
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/selfshot.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-linking.patch

set +e +o pipefail
