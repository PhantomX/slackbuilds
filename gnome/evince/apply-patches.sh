
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugzilla.redhat.com/show_bug.cgi?id=562648
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-t1font-mapping.patch

set +e +o pipefail
