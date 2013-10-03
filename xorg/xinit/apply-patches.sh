
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xinit-1.3.0-client-session.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xinit-1.0.9-unset.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/xorg-x11-xinit-1.3.2-systemd-logind.patch

set +e +o pipefail
