
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xinit-1.3.0-client-session.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xinit-1.0.9-unset.patch

set +e +o pipefail
