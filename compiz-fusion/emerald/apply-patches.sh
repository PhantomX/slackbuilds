
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/DSO.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/05_build_without_gtk_disable_deprecated.patch
# two more parameters have been added to decor_quads_to_property
# in compiz-0.9.4
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-0.8.5-api-change.patch

set +e +o pipefail
