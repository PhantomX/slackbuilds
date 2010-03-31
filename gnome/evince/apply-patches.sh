
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# https://bugzilla.redhat.com/show_bug.cgi?id=562648
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-t1font-mapping.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-deprecated-functions.patch

set +e +o pipefail
