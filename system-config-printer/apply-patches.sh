
set -e -o pipefail

SB_PATCHDIR=${CWD}/patches

# patch -p0 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-no-job-notifications.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-bug726682.patch
patch -p1 -E --backup --verbose -i ${SB_PATCHDIR}/${NAME}-no-packagekit.patch

set +e +o pipefail
