
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .gtk2 --verbose -i ${SB_PATCHDIR}/avahi-0.6.26-gtk2.patch

set +e +o pipefail
