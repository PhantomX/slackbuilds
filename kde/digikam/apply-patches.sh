
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -d extra/libkvkontakte -i ${SB_PATCHDIR}/${NAME}-2.1.0-libkvkontakte-libdir.patch

set +e +o pipefail
