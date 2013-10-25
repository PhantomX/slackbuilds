
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .qstring --verbose -i ${SB_PATCHDIR}/${NAME}-qstring.patch

set +e +o pipefail
