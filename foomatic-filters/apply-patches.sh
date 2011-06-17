
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# Use libdir.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-libdir.patch
# Use mkstemp, not mktemp.
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/foomatic-mkstemp.patch
# Use colord
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/foomatic-colord.patch

set +e +o pipefail
