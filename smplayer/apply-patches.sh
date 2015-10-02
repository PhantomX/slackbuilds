
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup -z .desktop-files --verbose -i ${SB_PATCHDIR}/${NAME}-14.9.0-desktop-files.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-14.9.0.6966-system-qtsingleapplication.patch

set +e +o pipefail
