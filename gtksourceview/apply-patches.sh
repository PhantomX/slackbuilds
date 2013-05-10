
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=661068
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.11.2-cflags.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=672823
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.11-fix-GCONST-def.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.11-add-libs.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.11-glib-unicode-constant.patch

set +e +o pipefail
