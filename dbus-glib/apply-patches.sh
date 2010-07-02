
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
# https://bugs.freedesktop.org/show_bug.cgi?id=28835
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/0001-Fix-lookup-of-regular-properties-when-shadow-propert.patch

set +e +o pipefail
