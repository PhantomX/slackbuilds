
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p0 -E --backup -z .config --verbose -i ${SB_PATCHDIR}/${NAME}-config.patch
patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-system-qtsingleapplication.patch

set +e +o pipefail
