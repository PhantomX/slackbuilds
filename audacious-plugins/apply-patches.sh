
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.5-alpha1-xmms-skindir.patch
# fix hardcoded libdir replacement
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-2.4-libdir.patch

set +e +o pipefail
