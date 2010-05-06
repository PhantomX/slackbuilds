
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-cantor_part_desktop_fix.patch
patch -p0 -E --backup -z .dso --verbose -i ${SB_PATCHDIR}/${NAME}-4.4.3-cln.patch

set +e +o pipefail
