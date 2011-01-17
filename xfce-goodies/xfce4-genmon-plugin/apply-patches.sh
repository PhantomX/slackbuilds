
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# http://bugzilla.xfce.org/show_bug.cgi?id=3896
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.2-no-zombies.patch
# Fixes underlinking against libxfcegui and libgcrypt
# http://bugzilla.xfce.org/show_bug.cgi?id=7097
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-3.2-underlink.patch

set +e +o pipefail
