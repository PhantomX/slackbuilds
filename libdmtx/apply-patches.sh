
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.2-rb192.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.7.2-php54.patch

set +e +o pipefail
