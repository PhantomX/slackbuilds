
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.0-gettext-garbage.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-1.1.0-gtk3-tab-too-small.patch

set +e +o pipefail
