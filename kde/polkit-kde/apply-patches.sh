
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1-0.95.1-ImplicitDSOLinking.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1_root-password.patch
patch -p4 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.95.1-gcc45.patch
# https://bugs.kde.org/show_bug.cgi?id=248636
patch -p4 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.95.1-polkit.patch

set +e +o pipefail
